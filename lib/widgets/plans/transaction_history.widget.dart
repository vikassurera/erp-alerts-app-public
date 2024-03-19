import 'package:erpalerts/service/plan.service.dart';
import 'package:flutter/material.dart';

// Models
import 'package:erpalerts/models/plan.model.dart';

// Widgets
import 'package:erpalerts/Widgets/plans/transaction_info_tile.widget.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key, required this.onViewDetail});
  final Function(Plan, BuildContext) onViewDetail;

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  bool _isLoading = false;
  List<Plan> _plans = [];

  void fetchPlans() async {
    try {
      setState(() {
        _isLoading = true;
      });

      _plans = await PlanService().getPlans();
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchPlans();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Transaction History",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _plans.length,
                    itemBuilder: (context, index) {
                      return TransactionInfoTile(
                        plan: _plans[index],
                        onViewDetail: () {
                          widget.onViewDetail(_plans[index], context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
