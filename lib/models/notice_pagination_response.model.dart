import 'package:erpalerts/models/notice.model.dart';

class NoticePaginationResponse {
  final List<Notice> notices;
  final int page;
  final int limit;
  final int count;
  final int totalCount;
  final int pages;

  NoticePaginationResponse({
    required this.notices,
    required this.page,
    required this.limit,
    required this.count,
    required this.totalCount,
    required this.pages,
  });

  factory NoticePaginationResponse.fromMap(Map<String, dynamic> json) {
    return NoticePaginationResponse(
      notices: List<Notice>.from(json["data"].map((x) => Notice.fromMap(x))),
      page: json["page"],
      limit: json["pageSize"],
      count: json["count"],
      totalCount: json["totalCount"],
      pages: json["pages"],
    );
  }
}
