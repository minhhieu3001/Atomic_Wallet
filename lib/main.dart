import 'package:atomic/ui/screen/buy.dart';
import 'package:atomic/ui/screen/exchange.dart';
import 'package:atomic/ui/screen/history.dart';
import 'package:atomic/ui/screen/login.dart';
import 'package:atomic/ui/screen/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../ui/component.dart';
import '../ui/screen/home.dart';
import '../ui/screen/settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<FirebaseApp> _initializeFireBase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atomic Wallet',
      home: FutureBuilder(
        future: _initializeFireBase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginPage();
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

enum TabItem { home, history, convert, buy }

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with TickerProviderStateMixin {
  TabItem _currentItem = TabItem.home;
  final List<TabItem> _bottomTabs = [
    TabItem.home,
    TabItem.history,
    TabItem.convert,
    TabItem.buy
  ];

  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 5),
    () => "loaded",
  );

  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;

  @override
  void initState() {
    super.initState();
    //fetchCoin();
    //Timer.periodic(const Duration(seconds: 10), (timer) => fetchCoin());
    animation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1.0).animate(animation);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animation.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animation.forward();
      }
    });
    animation.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: _calculation,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.blueGrey[50],
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(100.0),
                child: SafeArea(
                  child: appBar(
                    left: const Icon(Icons.notes, color: Colors.white),
                    title: "0.00 \$",
                    right: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Settings()));
                        },
                        child: const Icon(Icons.settings, color: Colors.white)),
                  ),
                ),
              ),
              body: _buildScreen(),
              bottomNavigationBar: _bottomNavigationBar(),
            );
          } else {
            return FadeTransition(
                opacity: _fadeInFadeOut,
                child: Container(
                    width: 225,
                    height: 225,
                    color: const Color.fromRGBO(32, 43, 71, 1),
                    child: Center(
                      child: Stack(children: <Widget>[
                        Positioned(
                            child: Container(
                                width: 225,
                                height: 225,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/atomic.png'),
                                      fit: BoxFit.fitWidth),
                                ))),
                      ]),
                    )));
          }
        });
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color.fromRGBO(52, 68, 111, 0.5),
      items: _bottomTabs
          .map((tabItem) => _bottomNavigationBarItem(_icon(tabItem), tabItem))
          .toList(),
      onTap: _onSelectTab,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      IconData icon, TabItem tabItem) {
    final Color color =
        _currentItem == tabItem ? Colors.black12 : Colors.white60;

    return BottomNavigationBarItem(icon: Icon(icon, color: color), label: '');
  }

  void _onSelectTab(int index) {
    TabItem selectedTabItem = _bottomTabs[index];

    setState(() {
      _currentItem = selectedTabItem;
    });
  }

  IconData _icon(TabItem item) {
    switch (item) {
      case TabItem.home:
        return Icons.account_balance_wallet;
      case TabItem.history:
        return Icons.history;
      case TabItem.convert:
        return Iconsax.convert_card;
      case TabItem.buy:
        return Iconsax.buy_crypto;
      default:
        throw 'Unknown $item';
    }
  }

  Widget _buildScreen() {
    switch (_currentItem) {
      case TabItem.home:
        return const HomeScreen();
      case TabItem.history:
        return const History();
      case TabItem.convert:
        return Exchange();
      case TabItem.buy:
        return Buy();
      default:
        return HomeScreen();
    }
  }
}
