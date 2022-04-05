import 'package:atomic/InfoCoin.dart';
import 'package:atomic/ui/screen/home.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '/ui/component.dart';

class DetailWalletScreen extends StatelessWidget {
  const DetailWalletScreen({Key? key, required this.coin}) : super(key: key);
  final InfoCoin coin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(32, 43, 71, 100),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: SafeArea(
          child: appBar(
              left: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_ios, color: Colors.teal)),
              title: coin.name,
              right: const Icon(Icons.history),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            _cardWallet(coin: coin),
          ],
        ),
      ),
    );
  }

  LineChartData sampleData() {
    return LineChartData(
        lineTouchData: LineTouchData(
          enabled: false,
        ),
        gridData: FlGridData(
          show: false,
        ),
        titlesData: FlTitlesData(
          bottomTitles: SideTitles(
            showTitles: false,
          ),
          leftTitles: SideTitles(
            showTitles: false,
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        // minX: 0,
        maxX: 10,
        maxY: 4,
        minY: 0,
        lineBarsData: linesBarData(),
      );
  }

  List<LineChartBarData> linesBarData() {
    return [
      LineChartBarData(
        spots: [
          FlSpot(0, 3),
          FlSpot(1, 3.5),
          FlSpot(2, 2.5),
          FlSpot(3, 2.4),
          FlSpot(4, 2.0),
          FlSpot(5, 2.2),
          FlSpot(6, 1.9),
          FlSpot(7, 2.1),
          FlSpot(8, 1.6),
          FlSpot(9, 1),
          FlSpot(10, 0.5),
        ],
        isCurved: true,
        colors: const [
          Colors.blue,
        ],
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(show: true),
      ),
    ];
  }


  Widget _cardWallet({required InfoCoin coin}) {
    return Expanded(
        child:
          card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(coin.url, width: 50,),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(coin.balance.toString() + " ", style: const TextStyle(color: Colors.white, fontSize: 30),),
                Text(coin.name, style: const TextStyle(color: Colors.white54, fontSize: 30),),
              ],
            ),
            Text(coin.profit.toString(), style: const TextStyle(color: Colors.white, fontSize: 30),),
            Row(
              children: [
                const Text("\$ 31.11", style: TextStyle(color: Colors.white54),),
                const SizedBox(width: 50,),
                Text(coin.price.toString() + "(" + coin.percent.toString() + "%)", style: const TextStyle(color: Colors.white54))
              ],
            ),
            const Divider(
                color: Colors.white60,
                thickness: 1
            ),
            SizedBox(
              height: 180,
              child: Stack(children: [
                LineChart(
                  sampleData(),
                ),
              ]),
            ),
            const Divider(
                color: Colors.white60,
                thickness: 1
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("\$ 27.7",style: TextStyle(color: Colors.white54),),
              ],
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Day', style: TextStyle(color: Colors.white60),),
                  Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[200],
                          borderRadius: const BorderRadius.all(Radius.circular(30))),
                      child: const Text('Week', style: TextStyle(color: Colors.white),)),
                  const Text('Month',style: TextStyle(color: Colors.white60),),
                  const Text('Year',style: TextStyle(color: Colors.white60),),
                ],
              ),
            ),
            const SizedBox(height: 50,),
            Row(
              children: [
                Expanded(
                  child: _actionButton(
                    text: '      RECEIVE',
                    color: const Color.fromRGBO(53, 66, 101, 1),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: _actionButton(
                    text: '          SELL',
                    color: const Color.fromRGBO(0, 194, 255, 1),
                  ),
                ),
              ],
            )
            ]
        ),)
    );
  }

  Widget _actionButton({required Color color, required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all( Radius.circular(30)),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white),),
    );
  }
}
