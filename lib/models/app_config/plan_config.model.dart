class PlanConfig {
  static const String currencyKey = "currency";
  static const String priceKey = "price";
  static const String enabledKey = "enabled";

  PlanConfig({
    required this.currency,
    required this.price,
    required this.enabled,
  });

  final String currency;
  final String price;
  final bool enabled;

  factory PlanConfig.fromMap(Map<String, dynamic> json) => PlanConfig(
        currency: json[PlanConfig.currencyKey],
        price: json[PlanConfig.priceKey],
        enabled: json[PlanConfig.enabledKey] == true,
      );
}
