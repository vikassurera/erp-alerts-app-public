import 'package:get/get.dart';

// Models
import 'package:erpalerts/models/plan.model.dart';
import 'package:erpalerts/models/pricing.model.dart';

// Services
import 'package:erpalerts/service/pricing.service.dart';

// Controllers
import 'package:erpalerts/controllers/user.controller.dart';

class PricingController extends GetxController {
  final PricingService _pricingService = PricingService();

  // STATES
  var loading = false.obs;
  var refreshing = false.obs;

  final Rx<List<Pricing>> _pricing = Rx<List<Pricing>>([]);
  final Rx<Pricing?> _selectedPricing = Rx<Pricing?>(null);
  final Rx<Plan?> _plan = Rx<Plan?>(null);

  // GETTERS
  bool get isLoading => loading.value;
  bool get eanblePayment {
    final access = Get.find<UserController>().mainScreenAccess;
    final enablePayment = (access == MAIN_SCREEN_ACCESS.PURCHASE_PLAN) ||
        (access == MAIN_SCREEN_ACCESS.PLAN_EXPIRED);
    return enablePayment;
  }

  List<Pricing> get pricing => [..._pricing.value];
  Pricing? get selectedPricing => _selectedPricing.value;

  // API CALLS
  fetchPricingData() async {
    try {
      loading.value = true;

      final pricing = await _pricingService.getPricings();
      _pricing.value = pricing;
    } catch (error) {
      print(error);
      // TODO: show error on UI
    } finally {
      loading.value = false;
    }
  }

  Future<void> refreshPricingData() async {
    try {
      refreshing.value = true;

      final pricing = await _pricingService.getPricings();
      _pricing.value = pricing;
    } catch (error) {
      print(error);
      // TODO: show error on UI
    } finally {
      refreshing.value = false;
    }
  }

  void selectPricing(int index) {
    if (index < _pricing.value.length && index >= 0) {
      _selectedPricing.value = _pricing.value[index];
    } else {
      _selectedPricing.value = null;
    }
    _plan.value = null;
  }
}
