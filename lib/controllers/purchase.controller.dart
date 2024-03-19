import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

// Config
import 'package:erpalerts/config/prod.config.dart';

// Constants
import 'package:erpalerts/constants/app_info.dart';

// Models
import 'package:erpalerts/models/plan.model.dart';

// Services
import 'package:erpalerts/service/plan.service.dart';

// Controllers
import 'package:erpalerts/controllers/pricing.controller.dart';
import 'package:erpalerts/controllers/user.controller.dart';

// Utils
import 'package:erpalerts/utils/error.util.dart';

const TAG = '[PurchasePlanController]';

class PurchaseController extends GetxController {
  // VARIABLES

  final PlanService _planService = PlanService();

  // STATES
  final _buying = false.obs;
  final _errorMessage = Rx<String?>(null);
  Plan? _plan;

  // GETTERS
  bool get isBuying => _buying.value;
  bool get isErrorMessage => _errorMessage.value != null;
  String get errorMsg => _errorMessage.value ?? "";
  bool get enablePayment => Get.find<PricingController>().eanblePayment;

  // LIFE CYCLE
  @override
  void onInit() {
    super.onInit();
    _buying.value = false;
    _errorMessage.value = null;
  }

  @override
  void onClose() {
    super.onClose();
    _buying.close();
    _errorMessage.close();
  }

  // METHODS
  Future<void> capturePayment({
    String? paymentId,
    String? orderId,
    String? signature,
    required Function({bool closeParentModal}) dismissModal,
  }) async {
    try {
      if (paymentId == null || orderId == null || signature == null) {
        _errorMessage.value = "Something went wrong";
        return;
      }

      _buying.value = true;
      final Plan plan = _plan!;

      // API Call
      await _planService.capturePayment(
        planId: plan.id,
        paymentId: paymentId,
        orderId: orderId,
        signature: signature,
      );

      // Update User - Refresh the data
      dismissModal(closeParentModal: true);
      Get.find<UserController>().setupUser();
    } on DioError catch (error) {
      _errorMessage.value = getMessageFromError(error);
    } catch (error) {
      print(error);
      _errorMessage.value = "Something went wrong";
    } finally {
      _buying.value = false;
    }
  }

  void handlePaymentError(PaymentFailureResponse response) {
    _buying.value = false;
    _errorMessage.value = "Something went wrong";

    // TODO: mixpanel tracking
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    _buying.value = false;
    _errorMessage.value = "Something went wrong";

    // TODO: mixpanel tracking
  }

  Future<Map<String, Object>?> getBuyOptions() async {
    _errorMessage.value = null;

    try {
      // Get Pricing object
      final pricing = Get.find<PricingController>().selectedPricing;
      if (pricing == null) {
        _errorMessage.value = "Please select a Plan";
        return null;
      }

      // Get User email
      final userEmail = Get.find<UserController>().email;
      _buying.value = true;

      // Fetch the plan with this pricing Id
      _plan = await _planService.getPlanForPricing(pricing.id);

      final options = {
        'key': Config.razorpayApiKey,
        'image': AppInfo.logoUrl,
        'amount': pricing.price, //in the smallest currency sub-unit.
        'name': pricing.title,
        'order_id': _plan!.orderId, // Generate order_id using Orders API
        'description': pricing.receipt,
        'timeout': 60 * 5, // in seconds // 5 minutes
        'prefill': {
          'email': userEmail,
        }
      };

      return options;
    } on DioError catch (error) {
      _errorMessage.value = getMessageFromError(error);
    } catch (error) {
      print(error);
      _errorMessage.value = "Something went wrong";
    } finally {
      _buying.value = false;
    }

    return null;
  }
}
