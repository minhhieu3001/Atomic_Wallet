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

Future<List<InfoCoin>> fetchCoin(String searchValue) async {
  final response = await http.get(Uri.parse(
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));

  if (response.statusCode == 200) {
    final List list = json.decode(response.body);
    List<InfoCoin> coins = list.map((model) => InfoCoin.fromJson(model)).toList();
    if(searchValue == "") {
      return coins;
    } else {
      List<InfoCoin> rs = [];
      for(InfoCoin i in coins) {
        if(i.name.toLowerCase().contains(searchValue)) {
          rs.add(i);
        }
      }
      return rs;
    }
  } else {
    throw Exception('Failed to load coins');
  }
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? debouncer;

  // TextEditingController _searchValue = new TextEditingController();
  String _searchValue = "";

  List<InfoCoin> coins = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
      VoidCallback callback, {
        Duration duration = const Duration(milliseconds: 1000),
      }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final coins = await fetchCoin(_searchValue);

    setState(() => this.coins = coins);
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
                onChanged: search,
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
          ListCoin(coins: coins)
        ]
      )
    );
  }

  Future search(String searchValue) async => debounce(() async {
    final coins = await fetchCoin(searchValue);

    if (!mounted) return;

    setState(() {
      this._searchValue = _searchValue;
      this.coins = coins;
    });
  });
}



