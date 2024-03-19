class NoticePaginationParams {
  final int? page;
  final int? limit;
  final String? type;
  final String? category;
  final DateTime? beforeDate;
  final DateTime? afterDate;

  NoticePaginationParams({
    this.page,
    this.limit,
    this.type,
    this.category,
    this.beforeDate,
    this.afterDate,
  });

  copyWith({
    int? page,
    int? limit,
    String? type,
    String? category,
    DateTime? beforeDate,
    DateTime? afterDate,
  }) {
    return NoticePaginationParams(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      type: type,
      category: category,
      beforeDate: beforeDate ?? this.beforeDate,
      afterDate: afterDate ?? this.afterDate,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (page != null) map["page"] = page;
    if (limit != null) map["pageSize"] = limit;
    if (type != null) map["type"] = type;
    if (category != null) map["category"] = category;
    if (beforeDate != null)
      map["beforeDate"] = beforeDate!.millisecondsSinceEpoch;
    if (afterDate != null) map["afterDate"] = afterDate!.millisecondsSinceEpoch;
    return map;
  }
}
