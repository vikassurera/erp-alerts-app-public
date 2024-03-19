import 'package:erpalerts/api/api_client.dart';
import 'package:erpalerts/api/endpoints.dart';
import 'package:erpalerts/models/pricing.model.dart';

const TAG = '[PricingService]';

class PricingService {
  final ApiClient _apiClient = ApiClient();

  // Fetch all pricings
  Future<List<Pricing>> getPricings() async {
    final response = await _apiClient.get(Endpoints.getPricings);
    final data = response.data["pricing"];
    return List<Pricing>.from(data.map((x) => Pricing.fromMap(x)));
  }

  Future<Pricing> fetchOnePricing(String id) async {
    final response = await _apiClient.get(Endpoints.getPricingRoute(id));
    final data = response.data["pricing"];
    return Pricing.fromMap(data);
  }
}
