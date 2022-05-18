import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../service/Database.dart';
import '../../model/CoinData.dart';
import '../../model/InfoCoin.dart';
import '../../model/Wallet.dart';
import 'chooseCoin.dart';

class Buy extends StatefulWidget {
  final Wallet wallet;
  const Buy({Key? key, required this.wallet}) : super(key: key);

  @override
  State<Buy> createState() => _BuyState();
}

class _BuyState extends State<Buy> {

  Database db= new Database();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Wallet wallet = Wallet(uid: "", coins: [], money: 0);

  String value = '';

  InfoCoin newCoin = InfoCoin(imageUrl: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
      name: "btc", price: 40232, percent: 1.87614, balance: 0, profit: 0, highest: 41004, lowest: 39444);

  void settingValue(String text) {
    var number = text == "" ? 0 : double.parse(text);
    setState(() {
      if(number == 0 ) {
        value = '0';
      } else {
        value = (number / newCoin.price).toString().substring(0, 10);
      }
    });
  }

  @override
  void initState() {
    final docs = firestore.collection("Wallet").where("uid", isEqualTo: _auth.currentUser!.uid).get()
        .then((snapshot) {
      wallet.uid = snapshot.docs[0].get("uid");
      wallet.money = snapshot.docs[0].get("money").toDouble();
    });
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
            child: Text("BUY", style: TextStyle(color: Colors.white, fontSize: 30),),
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
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network("https://icons.iconarchive.com/icons/cjdowner/cryptocurrency-flat/1024/Dollar-USD-icon.png", width: 48,),
                          const SizedBox(width: 10,),
                          const Text("USD", style: TextStyle(color: Colors.white),),
                          const SizedBox(width: 10,),
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
                              Text(value, style: const TextStyle(color: Colors.white),),
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
                if(double.parse(value)*newCoin.price > wallet.money) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text("You don't have enough money. Try again"),
                  ),);
                } else {
                  final docs = firestore.collection("Wallet").where("uid", isEqualTo: _auth.currentUser!.uid).get()
                      .then((snapshot) {
                    final List list = snapshot.docs[0].get("coins");
                    List<CoinData> coinDatas = list.map((model) =>
                        CoinData.fromJson(model)).toList();
                    CoinData coin = new CoinData(name: newCoin.name.toUpperCase(), have: double.parse(double.parse(value).toStringAsFixed(5)));
                    List<Map> coins = [];
                    bool check = true;
                    for(CoinData i in coinDatas) {
                      if(coin.name.toUpperCase() == i.name.toUpperCase()) {
                        i.have = i.have + coin.have;
                        i.have = double.parse(i.have.toStringAsFixed(5));
                        check = false;
                      }
                      coins.add(i.toMap());
                    }
                    if(check == true) coins.add(coin.toMap()); else {check = true;}
                    //print(snapshot.docs[0].id.toString());
                    wallet.money = double.parse((wallet.money - double.parse(value) * newCoin.price).toStringAsFixed(8));
                    db.update(coins, snapshot.docs[0].id.toString(), wallet.money);
                  });
                  showMyAlertDialog(context, "Buy " + newCoin.name.toUpperCase() + " success!");
                }
              },
              child: const Text("BUY", style: TextStyle(color: Colors.white, fontSize: 20),),
            ),
          )
        ],
      ),),
    );
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
              if(text.indexOf("Buy") != 0) {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => MainApp(uid:wallet.uid)));
              }
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
