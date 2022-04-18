import 'package:flutter/material.dart';
import '../../InfoCoin.dart';
import '../screen/detail_wallet.dart';

class ListCoin extends StatelessWidget {

  final List<InfoCoin> coins;

  const ListCoin({Key? key, required this.coins}) : super(key: key);

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
