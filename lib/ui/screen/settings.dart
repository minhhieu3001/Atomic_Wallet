import 'package:flutter/material.dart';
import '/ui/component.dart';
import '/ui/screen/detail_wallet.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(32, 43, 71, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40,),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
            // decoration: BoxDecoration(border:Border(bottom: BorderSide(width: 1.0, color: Colors.grey)) ),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios, color: Colors.teal)
                ),
                const SizedBox(width: 30,),
                const Text(" Tools", style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.w600),)
              ],
            ),
          ),

          const Padding(padding: EdgeInsets.fromLTRB(25, 10, 0, 0),
            child: Text("Atomic Wallet Token", style:  TextStyle(fontSize: 25, color: Colors.white,)),),
          Container(
            margin: const EdgeInsets.only(left: 25, right: 25),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              children: [
                Image.network("https://cdn-icons-png.flaticon.com/512/217/217853.png", width: 30, height: 30,),
                Text(" Buy AWC", style: TextStyle(fontSize: 20, color: Colors.white54,),)
              ],
            ),),
          Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              children: [
                Image.network("https://cdn-icons-png.flaticon.com/512/218/218466.png",width: 30, height: 30,),
                Text(" Membership", style: TextStyle(fontSize: 20, color: Colors.white54,),)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              children: [
                Image.network("https://cdn-icons-png.flaticon.com/512/260/260300.png",width: 30, height: 30,),
                Text(" Wallet Connect", style: TextStyle(fontSize: 20, color: Colors.white54,),)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              children: [
                Image.network("https://cdn.iconscout.com/icon/free/png-256/global-currency-1543267-1305758.png",width: 30, height: 30,),
                Text(" Local Currency", style: TextStyle(fontSize: 20, color: Colors.white54,),)
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
            padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
            child: Row(
              children: [
                Image.network("https://icons.iconarchive.com/icons/paomedia/small-n-flat/1024/sign-add-icon.png",width: 30, height: 30,),
                Text(" Add Token", style: TextStyle(fontSize: 20, color: Colors.white54,),)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
            padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
            child: Row(
              children: [
                Image.network("https://i.dlpng.com/static/png/5113838-notification-icons-download-3229-free-png-and-vector-icons-notification-png-512_512_preview.png",width: 30, height: 30,),
                Text(" Notifications", style: TextStyle(fontSize: 20, color: Colors.white54,),)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
            padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
            child: Row(
              children: [
                Image.network("https://codefly.vn/wp-content/uploads/code/2020/08/5136/project/assets/security-icon.png",width: 30, height: 30,),
                Text(" Security", style: TextStyle(fontSize: 20, color: Colors.white54,),)
              ],
            ),
          ),
          Padding(padding: EdgeInsets.fromLTRB(25, 10, 0, 0),
            child: Text("Support", style:  TextStyle(fontSize: 25, color: Colors.white,)),),
          Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
            padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
            child: Row(
              children: [
                Image.network("https://www.iconpacks.net/icons/2/free-chat-support-icon-1721-thumb.png",width: 30, height: 30,),
                Text(" Support", style: TextStyle(fontSize: 20, color: Colors.white54,),)
              ],
            ),
          )
          ,
          Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
            padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
            child: Row(
              children: [
                Image.network("https://cdn-icons-png.flaticon.com/512/3090/3090423.png",width: 30, height: 30,),
                Text(" Community", style: TextStyle(fontSize: 20, color: Colors.white54,),)
              ],
            ),
          )
          ,
          Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
            padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
            child: Row(
              children: [
                Image.network("https://icons-for-free.com/iconfiles/png/512/about-131964752256876096.png",width: 30, height: 30,),
                Text(" About", style: TextStyle(fontSize: 20, color: Colors.white54,),)
              ],
            ),
          )


        ],
      ),
    );
  }
}