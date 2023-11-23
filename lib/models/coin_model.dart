class CoinModel {
  // ignore: non_constant_identifier_names
  final String value_changer;
  // ignore: non_constant_identifier_names
  final double price_balance;
  CoinModel(
  {
    // ignore: non_constant_identifier_names
    required this.value_changer,
    // ignore: non_constant_identifier_names
    required this.price_balance,
  }
  );

  Map<String, dynamic> toJson() {
    return {
      'value_changer': value_changer,
      'price_balance': price_balance,
    };
  }

  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
      value_changer: json['value_changer'],
      price_balance: json['price_balance']
    );
  }
}
