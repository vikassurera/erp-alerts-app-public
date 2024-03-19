import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Models
import 'package:erpalerts/models/pricing.model.dart';

// Services
import 'package:erpalerts/service/analytics.service.dart';

// Controllers
import 'package:erpalerts/controllers/pricing.controller.dart';

// Widgets
import 'package:erpalerts/widgets/contact/contact_section.widget.dart';
import 'package:erpalerts/widgets/purchase/plan_purchase.widget.dart';
import 'package:erpalerts/widgets/purchase/pricing_card.widget.dart';

class PricingList extends StatefulWidget {
  const PricingList({super.key});

  @override
  State<PricingList> createState() => _PricingListState();
}

class _PricingListState extends State<PricingList> {
  final PricingController controller = Get.put(PricingController());

  @override
  void initState() {
    AnalyticsService().register(Event.APP_VIEW_PRICING);
    controller.fetchPricingData();
    super.initState();
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  void _showBottomSheet(BuildContext context, Pricing selectedPricing) {
    showModalBottomSheet<bool>(
      context: context,
      isDismissible: false,
      isScrollControlled: false,
      enableDrag: false,
      builder: (BuildContext context) {
        return Container(
          height: 270,
          padding: const EdgeInsets.all(20),
          child: PlanPurchaseWidget(
            selectedPricing: selectedPricing,
          ),
        );
      },
    ).then((value) {
      controller.selectPricing(-1);
      if (value != null && value) {
        Navigator.of(context).pop();
      }
    });
  }

  void onPricingSelection(int selectedIndex) {
    controller.selectPricing(selectedIndex);
    if (controller.selectedPricing != null) {
      _showBottomSheet(context, controller.selectedPricing!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Select an oreo plan for real-time internship and placement alerts.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 350,
                  child: ListView.builder(
                    itemCount: controller.pricing.length,
                    itemBuilder: (context, index) {
                      return PricingCard(
                        enablePayment: controller.eanblePayment,
                        pricing: controller.pricing[index],
                        onSelect: () => {onPricingSelection(index)},
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ContactSection(),
              ],
            ),
          ),
        );
      }
    });
  }
}
