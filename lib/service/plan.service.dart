// API
import 'package:erpalerts/api/api_client.dart';
import 'package:erpalerts/api/endpoints.dart';

// Models
import 'package:erpalerts/models/plan.model.dart';

const TAG = '[PlanService]';

class PlanService {
  final ApiClient _apiClient = ApiClient();

  // Fetch all plans
  Future<List<Plan>> getPlans() async {
    final response = await _apiClient.get(
      Endpoints.fetchPlans,
    );
    final data = response.data["plans"];
    return List<Plan>.from(data.map((x) => Plan.fromMap(x)));
  }

  // Fetch plan
  Future<Plan> getPlanForPricing(String pricingId) async {
    final response = await _apiClient.post(Endpoints.createPlan, {
      "pricingId": pricingId,
    });
    final data = response.data["plan"];
    return Plan.fromMap(data);
  }

  // Capture Payment
  Future<void> capturePayment({
    required String planId,
    required String paymentId,
    required String orderId,
    required String signature,
  }) async {
    final data = {
      'paymentId': paymentId,
      'orderId': orderId,
      'signature': signature,
    };

    await _apiClient.put(Endpoints.getPlanRoute(planId), data);
  }

  // This might throw error in case of no Plan generated
  Future<Plan?> getMyPlan() async {
    try {
      final response = await _apiClient.get(Endpoints.myPlan);
      final data = response.data["plan"];
      return Plan.fromMap(data);
    } catch (error) {
      return null;
    }
  }
}
