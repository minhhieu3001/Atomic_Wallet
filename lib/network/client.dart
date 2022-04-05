import 'package:http/http.dart' as http;

class Client {
  var baseurl = "https://testnet.binance.vision";
  Future<void> getInfoCoins() async {
    var url = "$baseurl/api/v3/ticker/24hr";
    var response = await http.get(url);
    print('status: ${response.statusCode}');
    print('data: ${response.body}');
  }
}