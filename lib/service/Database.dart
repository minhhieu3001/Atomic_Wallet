import 'package:atomic/model/CoinData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  late FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> update(List<Map> coins, String id, double money) async {
    try {
      await firestore
          .collection("Wallet")
          .doc(id).update({"coins": coins, "money": money});
    } catch (e) {
      print(e);
    }
  }
}