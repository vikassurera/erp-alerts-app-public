import 'package:flutter/material.dart';

class Plan {
  final String id;
  final String userId;
  final String orderId;
  final String pricingId;
  final String status; // ORDER_GENERATED, PAYMENT_SUCCESSFUL
  final bool paid;

  final DateTime? paidAt;
  final int? paidAmount;
  final String? paidCurrency;
  final DateTime? planExpiry;
  final bool? isExpired;
  final DateTime createdAt;

  Plan({
    required this.id,
    required this.userId,
    required this.orderId,
    required this.pricingId,
    required this.status,
    required this.paid,
    required this.paidAt,
    required this.paidAmount,
    required this.paidCurrency,
    required this.planExpiry,
    required this.isExpired,
    required this.createdAt,
  });

  int get amountPaid => ((paidAmount ?? 0) / 100).toInt();
  bool get isStatusSuccess => status == "PAYMENT_SUCCESSFUL";
  String get planState {
    if (isExpired == null) return "Inactive";
    if (isExpired == true) {
      return "Expired";
    } else {
      return "Active";
    }
  }

  Color get planStateColor {
    if (isExpired == null) return Colors.black;
    if (isExpired == true) {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }

  Plan copyWith({
    String? id,
    String? userId,
    String? orderId,
    String? pricingId,
    String? status,
    bool? paid,
    DateTime? paidAt,
    int? paidAmount,
    String? paidCurrency,
    DateTime? planExpiry,
    bool? isExpired,
    DateTime? createdAt,
  }) =>
      Plan(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        orderId: orderId ?? this.orderId,
        pricingId: pricingId ?? this.pricingId,
        status: status ?? this.status,
        paid: paid ?? this.paid,
        paidAt: paidAt ?? this.paidAt,
        paidAmount: paidAmount ?? this.paidAmount,
        paidCurrency: paidCurrency ?? this.paidCurrency,
        planExpiry: planExpiry ?? this.planExpiry,
        isExpired: isExpired ?? this.isExpired,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Plan.fromMap(Map<String, dynamic> json) => Plan(
      id: json["id"],
      userId: json["userId"],
      orderId: json["orderId"],
      pricingId: json["pricingId"],
      status: json["status"],
      paid: json["paid"],
      paidAt: json["paidAt"] != null
          ? DateTime.fromMillisecondsSinceEpoch(json["paidAt"])
          : null,
      paidAmount: json["paidAmount"],
      paidCurrency: json["paidCurrency"],
      planExpiry: json["planExpiry"] != null
          ? DateTime.fromMillisecondsSinceEpoch(json["planExpiry"])
          : null,
      isExpired: json["isExpired"],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json["createdAt"]));

  Map<String, dynamic> toMap() => {
        "id": id,
        "userId": userId,
        "orderId": orderId,
        "pricingId": pricingId,
        "status": status,
        "paid": paid,
        "paidAt": paidAt?.millisecondsSinceEpoch,
        "paidAmount": paidAmount,
        "paidCurrency": paidCurrency,
        "planExpiry": planExpiry?.millisecondsSinceEpoch,
        "isExpired": isExpired,
        "createdAt": createdAt.millisecondsSinceEpoch,
      };
}
