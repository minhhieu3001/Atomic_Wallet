import 'package:atomic/model/CoinData.dart';

class Wallet {
  String uid;
  List<CoinData> coins;
  double money;

  Wallet({required this.uid, required this.coins, required this.money});

}