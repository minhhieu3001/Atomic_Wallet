import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../model/InfoCoin.dart';

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
class ChooseCoin extends StatelessWidget {

  Future<List<InfoCoin>> coins = fetchCoin();

  ChooseCoin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(32, 43, 71, 1),
      appBar: AppBar(title: Text("List coin")),
      body: Column(
        children : [
          SizedBox(height: 20,),
          FutureBuilder<List<InfoCoin>>(future: coins, builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData) {
            return ListCoin1(coins: snapshot.data);
          } else {
            return CircularProgressIndicator();
          }
        }),
      ]
      )
    );
  }


}

class ListCoin1 extends StatelessWidget {

  final List<InfoCoin> coins;

  const ListCoin1({Key? key, required this.coins}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox(
          height: 80,
          child: ListView.builder(
              itemCount: coins.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: CoinBox1(coin: coins[index]),
                  onTap: () {
                    Navigator.pop(context, coins[index]);
                  },
                );
              }),
        ));
  }
}

class CoinBox1 extends StatelessWidget {
  const CoinBox1({Key? key, required this.coin}) : super(key: key);
  final InfoCoin coin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 100,
      child: Card(
          color: const Color.fromRGBO(52, 68, 111, 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const SizedBox(width: 15,),
              Image.network(coin.imageUrl, width: 50,),
              const SizedBox(width: 15,),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(coin.name.toUpperCase(), style:const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(coin.price.toString() + " \$", style: const TextStyle(color: Colors.white)),
                  Text("( " + coin.percent.toString() + " % )", style: TextStyle(color: (coin.percent >=0 ? Colors.green : Colors.redAccent),))
                ],
              )),
            ],
          )
      ),
    );
  }
}
