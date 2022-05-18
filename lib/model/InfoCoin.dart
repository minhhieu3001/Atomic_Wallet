
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'CoinData.dart';

class InfoCoin {
  String imageUrl, name;
  num price, percent, balance, profit, highest, lowest ;
  InfoCoin({required this.imageUrl, required this.name, required this.price, required this.percent,
    required this.balance, required this.profit, required this.highest, required this.lowest} );



  factory InfoCoin.fromJson(Map<String, dynamic> json) {
    return InfoCoin(
        imageUrl: json['image'],
        name: json['symbol'],
        price: json['current_price'],
        percent: json['price_change_percentage_24h'],
        balance: 0,
        profit: 0,
        highest: json['high_24h'],
        lowest: json['low_24h'],);
  }

  @override
  String toString() {
    return "{Coin: name: " + this.name + " ,balance: " + this.balance.toString() + " ,profit: " + this.profit.toString() + "}";
  }

}