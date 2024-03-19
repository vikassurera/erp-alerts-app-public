import 'package:erpalerts/service/pricing.service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Models
import 'package:erpalerts/models/plan.model.dart';
import 'package:erpalerts/models/pricing.model.dart';

class PlanDetail extends StatefulWidget {
  const PlanDetail({super.key, required this.plan});
  final Plan plan;

  @override
  State<PlanDetail> createState() => _PlanDetailState();
}

class _PlanDetailState extends State<PlanDetail> {
  bool _loading = false;
  Pricing? _pricing;

  fetchPricing() async {
    try {
      setState(() {
        _loading = true;
      });

      final pricingId = widget.plan.pricingId;
      _pricing = await PricingService().fetchOnePricing(pricingId);
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    fetchPricing();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : _pricing == null
            ? const Center(
                child: Text("Something went wrong!"),
              )
            : Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
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
                                _pricing!.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Validity for ${_pricing!.validityDays} days',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text:
                                  '${_pricing!.currencySymbol}${_pricing!.priceAmount}',
                              style: const TextStyle(
                                  fontSize: 30, color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '/${_pricing!.validity}',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.plan.planState,
                        style: TextStyle(
                          fontSize: 18,
                          color: widget.plan.planStateColor,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SelectableText("ID: ${widget.plan.id}"),
                      const SizedBox(
                        height: 3,
                      ),
                      SelectableText("Order ID: ${widget.plan.orderId}"),
                      const SizedBox(
                        height: 3,
                      ),
                      Text("Amount Paid: ₹${widget.plan.amountPaid}"),
                      const SizedBox(
                        height: 3,
                      ),
                      if (widget.plan.isExpired != null)
                        Text(
                          "Expiry: ${DateFormat.yMd().add_jm().format(widget.plan.planExpiry!)}",
                        ),
                      if (widget.plan.isExpired != null)
                        const SizedBox(
                          height: 3,
                        ),
                      if (widget.plan.paidAt != null)
                        Text(
                            "Paid At: ${DateFormat.yMd().add_jm().format(widget.plan.paidAt!)}"),
                      if (widget.plan.paidAt != null)
                        const SizedBox(
                          height: 3,
                        ),
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: 'Payment Status: ',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: widget.plan.status,
                              style: TextStyle(
                                // fontSize: 16,
                                color: widget.plan.isStatusSuccess == true
                                    ? Colors.green[600]
                                    : Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Generated At: ${DateFormat.yMd().add_jm().format(widget.plan.createdAt)}",
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Back"),
                      ),
                    ],
                  ),
                ),
              );
  }
}
