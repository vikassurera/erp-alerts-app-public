import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

// Models
import 'package:erpalerts/models/pricing.model.dart';

// Services
import 'package:erpalerts/service/analytics.service.dart';

// Controllers
import 'package:erpalerts/controllers/purchase.controller.dart';

class PlanPurchaseWidget extends StatefulWidget {
  final Pricing selectedPricing;

  const PlanPurchaseWidget({
    Key? key,
    required this.selectedPricing,
  }) : super(key: key);

  @override
  State<PlanPurchaseWidget> createState() => PlanPurchaseWidgetState();
}

class PlanPurchaseWidgetState extends State<PlanPurchaseWidget> {
  final PurchaseController controller = Get.put(PurchaseController());
  final _razorpay = Razorpay();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    });

    AnalyticsService().register(Event.APP_BUY_PLAN_WIDGET);

    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear();
    Get.delete<PurchaseController>();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    AnalyticsService().register(Event.APP_PAYMENT_SUCCESS);
    final paymentId = response.paymentId;
    final orderId = response.orderId;
    final signature = response.signature;

    controller.capturePayment(
      paymentId: paymentId,
      orderId: orderId,
      signature: signature,
      dismissModal: dismissModal,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    AnalyticsService().register(Event.APP_PAYMENT_FAILED);
    controller.handlePaymentError(response);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    AnalyticsService().register(Event.APP_PAYMENT_OTHER);
    controller.handleExternalWallet(response);
  }

  // purchase plan
  void buyNowClick() async {
    AnalyticsService().register(Event.APP_BUY_NOW_CLICK);
    final options = await controller.getBuyOptions();

    if (options != null) {
      // Open razorpay checkout
      _razorpay.open(options);
    }
  }

  void dismissModal({bool? closeParentModal}) {
    Navigator.pop(context, closeParentModal);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.selectedPricing.title,
                    style: const TextStyle(
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Validity for ${widget.selectedPricing.validityDays} days',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text:
                      '${widget.selectedPricing.currencySymbol}${widget.selectedPricing.priceAmount}',
                  style: const TextStyle(fontSize: 30, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: '/${widget.selectedPricing.validity}',
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 20,
              ),
            ),
            onPressed: controller.enablePayment
                ? (controller.isBuying ? null : buyNowClick)
                : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'BUY OREO',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.payment),
              ],
            ),
          ),
          if (controller.isErrorMessage)
            const SizedBox(
              height: 10,
            ),
          if (controller.isErrorMessage)
            Text(controller.errorMsg,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.red,
                )),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Subscription starts immediately after purchase.',
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: controller.isBuying ? null : () => dismissModal(),
            child: const Text(
              "Cancel",
            ),
          ),
        ],
      ),
    );
  }
}
