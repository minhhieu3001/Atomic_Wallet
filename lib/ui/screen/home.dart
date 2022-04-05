import 'package:atomic/InfoCoin.dart';
import 'package:flutter/material.dart';
import '/ui/component.dart';
import '/ui/screen/detail_wallet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
          ListCoin(),
        ]
      )
    );
  }

}

class ListCoin extends StatelessWidget {

  ListCoin({Key? key}) : super(key: key);

  final coins = InfoCoin.getList();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox(
          height: 80,
          child: ListView.builder(
              itemCount: coins.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: CoinBox(coin: coins[index]),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => DetailWalletScreen(coin: coins[index],)
                        )
                    );
                  },
                );
              }),
        ));
  }

}

class CoinBox extends StatelessWidget {
  const CoinBox({Key? key, required this.coin}) : super(key: key);
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
            Image.network(coin.url, width: 50,),
            const SizedBox(width: 15,),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(coin.name, style:const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                Text(coin.price.toString(), style: const TextStyle(color: Colors.white)),
                Text("( " + coin.percent.toString() + " % )", style: TextStyle(color: (coin.percent >=0 ? Colors.green : Colors.redAccent),))
              ],
            )),
            const SizedBox(width: 25,),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(coin.balance.toString(), style: const TextStyle(color: Colors.white)),
                Text("\$" + coin.profit.toString(), style: const TextStyle(color: Colors.white54)),
              ],
            )),
            const SizedBox(width: 10,)
          ],
        )
      ),
    );
  }
}