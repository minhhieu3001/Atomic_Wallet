import 'package:atomic/ui/screen/history.dart';
import 'package:flutter/material.dart';

class Exchange extends StatelessWidget {
  const Exchange({Key? key}) : super(key: key);
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
          Container(
            padding: EdgeInsets.all(5),
            height: 120,
            child: Card(
              color: const Color.fromRGBO(80, 104, 168, 1),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const SizedBox(width: 15,),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("You send:", style:TextStyle(color: Colors.white)),
                    Padding(
                      padding: EdgeInsets.only(right: 200),
                      child: TextField(
                              decoration: InputDecoration(
                              labelText: "0",
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 1.0),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
                const SizedBox(width: 25,),
                Expanded(child: chooseButton(name: "ETH"))
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
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("You send:", style:TextStyle(color: Colors.white)),
                        Padding(
                            padding: EdgeInsets.only(right: 200),
                            child: TextField(
                              decoration: InputDecoration(
                                  labelText: "0",
                                  labelStyle: TextStyle(color: Colors.white),
                              ),
                            )),
                      ],
                    ),
                    ),
                    const SizedBox(width: 25,),
                    Expanded(child: chooseButton(name: "BTC"))
                  ],
                )
            ),
          ),
          SizedBox(height: 15,),
          Row(
            children: [
              SizedBox(width: 15,),
              Column(
                children: [
                  Text("You have:", style: TextStyle(color: Colors.white60, fontSize: 20)),
                  Text("0 ETH",style: TextStyle(color: Colors.white, fontSize: 20),),
                ],
              ),
              SizedBox(width: 150,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all( Radius.circular(30)),
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                ),
                child: Text("SEND ALL", style: const TextStyle(color: Colors.white, fontSize: 18),),
              )
            ],
          ),
          SizedBox(height: 80,),
          SizedBox(
            height: 60,
            width: 350,
            child: RaisedButton(color: const Color.fromRGBO(139, 136, 136, 0.3),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              onPressed: (){},
              child: const Text("EXCHANGE", style: TextStyle(color: Colors.white24, fontSize: 20),),
            ),
          )
        ],
      ),
    );
  }
  Widget chooseButton({required String name}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(
        children: [
          //image
          Text(name, style: const TextStyle(color: Colors.white),),
          const SizedBox(width: 10,),
          const Icon(Icons.keyboard_arrow_down_outlined)
        ],
      )
    );
  }
}

