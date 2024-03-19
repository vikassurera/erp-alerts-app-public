// API
import 'package:erpalerts/api/api_client.dart';
import 'package:erpalerts/api/endpoints.dart';

// Models
import 'package:erpalerts/models/update.dart';
import 'package:erpalerts/models/notice_pagination_params.model.dart';
import 'package:erpalerts/models/notice_pagination_response.model.dart';
import 'package:erpalerts/models/notice.model.dart';

const TAG = '[NoticeService]';

class NoticeService {
  final ApiClient _apiClient = ApiClient();

  Future<NoticePaginationResponse> fetchNotices(
      NoticePaginationParams params) async {
    final response = await _apiClient.get(
      Endpoints.getNotices,
      queryParameters: params.toMap(),
    );

    final data = response.data;

    return NoticePaginationResponse.fromMap(data);
  }

  Future<Notice> fetchNotice(String id) async {
    final response = await _apiClient.get(Endpoints.getNotice(id));
    final data = response.data;
    return Notice.fromMap(data);
  }

  // App Updates
  Future<List<Update>> fetchAppUpdates() async {
    final response = await _apiClient.get(Endpoints.getUpdates);
    final data = response.data["updates"];
    return List<Update>.from(data.map((x) => Update.fromMap(x)));
  }
}
