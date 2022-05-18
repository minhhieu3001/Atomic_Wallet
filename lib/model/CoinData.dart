class CoinData {
  String name;
  double have;

  CoinData({required this.name, required this.have});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'have': have,
    };
  }

  factory CoinData.fromJson(Map<String, dynamic> coinsJson) => CoinData(
      name: coinsJson["name"],
      have: coinsJson["have"],
      );
}