import 'dart:convert';

Pricing pricingFromMap(String str) => Pricing.fromMap(json.decode(str));

String pricingToMap(Pricing data) => json.encode(data.toMap());

class Pricing {
  final String id;
  final String currency;
  final String currencySymbol;
  final int price;
  final String receipt;
  final String validity;
  final int validityDays;
  final int strikePrice;
  final List<String> features;
  final String title;

  Pricing({
    required this.id,
    required this.currency,
    required this.currencySymbol,
    required this.price,
    required this.receipt,
    required this.validity,
    required this.validityDays,
    required this.strikePrice,
    required this.features,
    required this.title,
  });

  int get priceAmount => (price / 100).toInt();
  int get strikeAmount => (strikePrice / 100).toInt();

  Pricing copyWith({
    String? id,
    String? currency,
    String? currencySymbol,
    int? price,
    String? receipt,
    String? validity,
    int? validityDays,
    int? strikePrice,
    List<String>? features,
    bool? isActive,
    String? title,
  }) =>
      Pricing(
        id: id ?? this.id,
        currency: currency ?? this.currency,
        currencySymbol: currencySymbol ?? this.currencySymbol,
        price: price ?? this.price,
        receipt: receipt ?? this.receipt,
        validity: validity ?? this.validity,
        validityDays: validityDays ?? this.validityDays,
        strikePrice: strikePrice ?? this.strikePrice,
        features: features ?? this.features,
        title: title ?? this.title,
      );

  factory Pricing.fromMap(Map<String, dynamic> json) => Pricing(
        id: json["id"],
        currency: json["currency"],
        currencySymbol: json['currencySymbol'],
        price: json["price"],
        receipt: json["receipt"],
        validity: json["validity"],
        validityDays: json["validityDays"],
        strikePrice: json["strikePrice"],
        title: json["title"],
        features: List<String>.from(json["features"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "currency": currency,
        "currencySymbol": currencySymbol,
        "price": price,
        "receipt": receipt,
        "validity": validity,
        "validityDays": validityDays,
        "strikePrice": strikePrice,
        "features": List<dynamic>.from(features.map((x) => x)),
        "title": title,
      };
}
