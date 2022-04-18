import 'package:atomic/ui/screen/chooseCoin.dart';
import 'package:flutter/material.dart';
import '../../InfoCoin.dart';

class Exchange extends StatefulWidget {
  const Exchange({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExchangeState();
}


class _ExchangeState extends State<Exchange> {

  String value = '';

  InfoCoin curCoin = InfoCoin(imageUrl: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
      name: "btc", price: 40232, percent: 1.87614, balance: 0, profit: 0, highest: 41004, lowest: 39444);
  InfoCoin newCoin = InfoCoin(imageUrl: "https://assets.coingecko.com/coins/images/279/large/ethereum.png?1595348880",
      name: "eth", price: 3047.02, percent: 0.284, balance: 0, profit: 0, highest: 3080.4, lowest: 2961.52);

  void settingValue(String text) {
    var number = text == "" ? 0 : double.parse(text);
    setState(() {
      if(number == 0 ) {
        value = '0';
      } else {
        value = (number * curCoin.price / newCoin.price).toString().substring(0, 10);
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(32, 43, 71, 1),
      body: Column(
        children:  [
          Row(
            children: const [
              SizedBox(width: 150,),
              Text("Exchange", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),),
              SizedBox(width: 100,),
              Icon(Icons.history),
            ],
          ),
          SizedBox(height: 20,),
          Container(
            padding: const EdgeInsets.all(5),
            height: 120,
            child: Card(
                color: const Color.fromRGBO(80, 104, 168, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(width: 15,),
                    Expanded(
                      child: TextField(
                        onChanged: (text) {
                            settingValue(text);
                        },
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        textInputAction: TextInputAction.send,
                        decoration: const InputDecoration(
                          labelText: "You send",
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    RaisedButton(
                      color: const Color.fromRGBO(80, 104, 168, 1),
                          onPressed: () {
                            displayCurCoinScreen(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(curCoin.imageUrl, width: 50,),
                              const SizedBox(width: 10,),
                              Text(curCoin.name.toUpperCase(), style: const TextStyle(color: Colors.white),),
                              const Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        )
                  ],
                )
            ),
          ),
          const Center(child: Icon(Icons.arrow_circle_down, size: 40,color: Colors.white60,)),
          Container(
            padding: const EdgeInsets.all(5),
            height: 120,
            child: Card(
                color: const Color.fromRGBO(191, 83, 174, 0.62),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(width: 15,),
                    Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("You receive: ", style: TextStyle(color: Colors.white),),
                            Text(value, style: const TextStyle(color: Colors.white),)
                          ]
                      )
                    ),
                    const SizedBox(width: 20,),
                    RaisedButton(
                      color: const Color.fromRGBO(191, 83, 174, 0.62),
                      onPressed: () {
                        displayNewCoinScreen(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(newCoin.imageUrl, width: 50,),
                          const SizedBox(width: 10,),
                          Text(newCoin.name.toUpperCase(), style: const TextStyle(color: Colors.white),),
                          const Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    )
                  ],
                )
            ),
          ),
          const SizedBox(height: 120,),
          SizedBox(
            height: 60,
            width: 350,
            child: RaisedButton(color: const Color.fromRGBO(139, 136, 136, 0.3),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              onPressed: (){
//?
              },
              child: const Text("EXCHANGE", style: TextStyle(color: Colors.white24, fontSize: 20),),
            ),
          )
        ],
      ),
    );
  }

  void displayCurCoinScreen(BuildContext context) async {
      final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseCoin()),);
      setState(() {
        curCoin = result;
      });
  }

  void displayNewCoinScreen(BuildContext context) async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseCoin()),);
    setState(() {
      newCoin = result;
    });
  }
}

