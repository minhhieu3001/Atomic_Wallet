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

Future<List<InfoCoin>> fetchCoin() async {
  final response = await http.get(Uri.parse(
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));

  if (response.statusCode == 200) {
    var list = json.decode(response.body) as List<dynamic>;
    List<InfoCoin> coins = list.map((model) => InfoCoin.fromJson(model)).toList();
    return coins;
  } else {
    throw Exception('Failed to load coins');
  }
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController _searchValue = new TextEditingController();

  Future<List<InfoCoin>> updateList(String value) async {
    List<InfoCoin> list = await fetchCoin();
    List<InfoCoin> rs = [];
    if(value == "") {
      return list;
    } else {
      for (InfoCoin i in list) {
        if (i.name.contains(value)) {
          rs.add(i);
        }
      }
      return rs;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(32, 43, 71, 1),
      body: Column(
        children:  [
          const SizedBox(
            height: 25,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: _searchValue,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.white,),
                  filled: true,
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
          FutureBuilder<List<InfoCoin>>(future: updateList(_searchValue.text), builder: (BuildContext context, AsyncSnapshot snapshot) {
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



