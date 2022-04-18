import 'package:atomic/InfoCoin.dart';
import 'package:flutter/material.dart';
import '../component/listCoin.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/foundation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

List<InfoCoin> parseCoins(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  List<InfoCoin> coins = list.map((model) => InfoCoin.fromJson(model)).toList();
  return coins;
}

Future<List<InfoCoin>> fetchCoin() async {
  List<InfoCoin> coins = [];
  final response = await http.get(Uri.parse(
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));

  if (response.statusCode == 200) {
    return compute(parseCoins, response.body);
  } else {
    throw Exception('Failed to load coins');
  }
}

class _HomeScreenState extends State<HomeScreen> {

  Future<List<InfoCoin>> coins = fetchCoin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(32, 43, 71, 1),
      body: Column(
        children:  [
          const SizedBox(
            height: 25,
          ),
          const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.white,),
                  fillColor: Color.fromRGBO(52, 68, 111, 0.5),
                  labelText: "Search...",
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                ),
              )
          ),
          const SizedBox(
            height: 15,
          ),
          FutureBuilder<List<InfoCoin>>(future: coins, builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData) {
                return ListCoin(coins: snapshot.data);
              } else {
                return CircularProgressIndicator();
              }
          })
        ]
      )
    );
  }

}



