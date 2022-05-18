import 'package:atomic/ui/screen/buy.dart';
import 'package:flutter/material.dart';
import '/ui/component.dart';
import '/ui/screen/detail_wallet.dart';


class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final imgPath = 'assets/images/history.jpg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(32, 43, 71, 1),
      body:SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Text("HISTORY", style: TextStyle(color: Colors.white, fontSize: 30),),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 20), child: Center(child: Text("Your transaction will appear here", style: TextStyle(color: Color.fromRGBO(196, 196, 196, 1), fontSize: 18, fontWeight: FontWeight.w400),), ) ,),
          Image.asset(imgPath, width: 380,),
          const SizedBox(height: 120,),
          SizedBox(
            height: 70,
            width: 350,
            child: RaisedButton(color: const Color.fromRGBO(64, 198, 240, 1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              onPressed: (){},
              child: const Text("BUY BITCOIN", style: TextStyle(color: Colors.white, fontSize: 20),),
            ),
          )
        ],
      ),),
    );
  }
}