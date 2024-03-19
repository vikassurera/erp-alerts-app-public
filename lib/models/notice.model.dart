class Notice {
  final String id;
  final String noticeId;
  final String year;
  final String type;
  final String category;
  final String company;
  final String noticeBody;
  final String formattedNotice;
  final DateTime noticeAt;
  final String noticeBy;
  final List<dynamic> noticeBodyUrls;
  final bool isAttachmentAvailable;
  final String? attachmentUrl;
  final String? attachmentFileName;
  final String? serverNoticeUrl;

  Notice({
    required this.id,
    required this.noticeId,
    required this.year,
    required this.type,
    required this.category,
    required this.company,
    required this.noticeBody,
    required this.formattedNotice,
    required this.noticeAt,
    required this.noticeBy,
    required this.noticeBodyUrls,
    required this.isAttachmentAvailable,
    this.attachmentUrl,
    this.attachmentFileName,
    this.serverNoticeUrl,
  });

  factory Notice.fromMap(Map<String, dynamic> json) => Notice(
        id: json["id"],
        noticeId: json["noticeId"],
        year: json["year"],
        type: json["type"],
        category: json["category"],
        company: json["company"],
        noticeBody: json["noticeBody"],
        formattedNotice: json["formattedNotice"],
        noticeAt: DateTime.fromMillisecondsSinceEpoch(json["noticeAt"]),
        noticeBy: json["noticeBy"],
        noticeBodyUrls:
            List<dynamic>.from(json["noticeBodyUrls"].map((x) => x)),
        isAttachmentAvailable: json["isAttachmentAvailable"],
        attachmentUrl: json["attachmentUrl"],
        attachmentFileName: json["attachmentFileName"],
        serverNoticeUrl: json["serverNoticeUrl"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "noticeId": noticeId,
        "year": year,
        "type": type,
        "category": category,
        "company": company,
        "noticeBody": noticeBody,
        "formattedNotice": formattedNotice,
        "noticeAt": noticeAt,
        "noticeBy": noticeBy,
        "noticeBodyUrls": List<dynamic>.from(noticeBodyUrls.map((x) => x)),
        "isAttachmentAvailable": isAttachmentAvailable,
        "attachmentUrl": attachmentUrl,
        "attachmentFileName": attachmentFileName,
        "serverNoticeUrl": serverNoticeUrl,
      };
}
