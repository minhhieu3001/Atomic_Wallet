import 'package:atomic/ui/screen/chooseCoin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../model/CoinData.dart';
import '../../model/InfoCoin.dart';
import '../../service/Database.dart';

class Exchange extends StatefulWidget {
  const Exchange({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExchangeState();
}


class _ExchangeState extends State<Exchange> {

  Database db= new Database();
  String value = '';
  
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
        value = (number * curCoin.price / newCoin.price).toStringAsFixed(5);
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
      body: SingleChildScrollView(
      child: Column(
        children:  [
          Center(
          child: Text("EXCHANGE", style: TextStyle(color: Colors.white, fontSize: 30),),
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
            child: RaisedButton(color: Colors.teal,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              onPressed: (){
                final docs = firestore.collection("Wallet").where("uid", isEqualTo: _auth.currentUser!.uid).get()
                    .then((snapshot) {
                  final List list = snapshot.docs[0].get("coins");
                  List<CoinData> coinDatas = list.map((model) =>
                      CoinData.fromJson(model)).toList();
                  if (coinDatas.length == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text("You don't have enough " + curCoin.name.toUpperCase() +". Try again"),
                    ),);
                  } else {
                    List<Map> coins = [];
                    bool check = false;
                    double curValue = double.parse(value) * newCoin.price / curCoin.price;
                    for(CoinData i in coinDatas) {
                      if(i.name.toUpperCase() == curCoin.name.toUpperCase()) {
                        if(i.have >= curValue) {
                          i.have =double.parse((i.have - curValue).toStringAsFixed(5));
                          check = true;
                        } else {
                          check = false;
                        }
                      }
                    }
                    if(check == true) {
                      for(CoinData i in coinDatas) {
                        if(i.name.toUpperCase() == newCoin.name.toUpperCase()) {
                          i.have = double.parse((i.have + double.parse(value)).toStringAsFixed(5));
                          check = false;
                        }
                      }
                      if(check == true) coins.add(new CoinData(name: newCoin.name.toUpperCase(),
                          have: double.parse((double.parse(value)).toStringAsFixed(5))).toMap());
                      showMyAlertDialog(context, "Exchange success!");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text("You don't have enough " + curCoin.name.toUpperCase() + ". Try again"),
                      ),);
                    }
                    for(CoinData i in coinDatas) {
                      coins.add(i.toMap());
                    }
                    db.update(coins, snapshot.docs[0].id.toString(),
                        snapshot.docs[0].get("money"));

                  }
                });
              },
              child: const Text("EXCHANGE", style: TextStyle(color: Colors.white, fontSize: 20),),
            ),
          )
        ],
      ),),
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
  showMyAlertDialog(BuildContext context,String text) {
    // Create AlertDialog
    AlertDialog dialog = AlertDialog(
      title: Text("Alert"),
      content: Text(text),
      actions: [
        ElevatedButton(
            child: Text("Ok"),
            onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MainApp(uid:_auth.currentUser?.uid)));
            }
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }
}

