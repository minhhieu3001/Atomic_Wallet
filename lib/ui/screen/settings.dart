import 'package:atomic/service/Database.dart';
import 'package:atomic/ui/screen/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../main.dart';
import '../../model/CoinData.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  TextEditingController addMoney = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController confirmPass = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
            // decoration: BoxDecoration(border:Border(bottom: BorderSide(width: 1.0, color: Colors.grey)) ),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child:
                        const Icon(Icons.arrow_back_ios, color: Colors.teal)),
                const SizedBox(
                  width: 30,
                ),
                const Text(
                  " Tools",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(25, 15, 0, 10),
            child: Text("Atomic Wallet Token",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                )),
          ),
          Container(
            margin: const EdgeInsets.only(left: 25, right: 25),
            decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              children: [
                Image.network(
                  "https://cdn-icons-png.flaticon.com/512/217/217853.png",
                  width: 30,
                  height: 30,
                ),
                Text(
                  " Buy AWC",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white54,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              children: [
                Image.network(
                  "https://cdn-icons-png.flaticon.com/512/218/218466.png",
                  width: 30,
                  height: 30,
                ),
                Text(
                  " Membership",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white54,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              children: [
                Image.network(
                  "https://cdn-icons-png.flaticon.com/512/260/260300.png",
                  width: 30,
                  height: 30,
                ),
                Text(
                  " Wallet Connect",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white54,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              children: [
                Image.network(
                  "https://cdn.iconscout.com/icon/free/png-256/global-currency-1543267-1305758.png",
                  width: 30,
                  height: 30,
                ),
                Text(
                  " Local Currency",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white54,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 3, left: 25, right: 25),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
            padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
            child: Row(
              children: [
                Image.network(
                  "https://i.dlpng.com/static/png/5113838-notification-icons-download-3229-free-png-and-vector-icons-notification-png-512_512_preview.png",
                  width: 30,
                  height: 30,
                ),
                Text(
                  " Notifications",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white54,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 3, left: 25, right: 25),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
            padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
            child: Row(
              children: [
                Image.network(
                  "https://codefly.vn/wp-content/uploads/code/2020/08/5136/project/assets/security-icon.png",
                  width: 30,
                  height: 30,
                ),
                Text(
                  " Security",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white54,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(25, 20, 0, 10),
            child: Text("Support",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                )),
          ),
          Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
            padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
            child: Row(
              children: [
                Image.network(
                  "https://www.iconpacks.net/icons/2/free-chat-support-icon-1721-thumb.png",
                  width: 30,
                  height: 30,
                ),
                Text(
                  " Support",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white54,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top:3, left: 25, right: 25),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
            padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
            child: Row(
              children: [
                Image.network(
                  "https://cdn-icons-png.flaticon.com/512/3090/3090423.png",
                  width: 30,
                  height: 30,
                ),
                Text(
                  " Community",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white54,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          RaisedButton(
            color: Color.fromRGBO(52, 68, 111, 0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),),
            child: Row(
              children: [
                Icon(Icons.add, color: Colors.white, size: 30,),
                SizedBox(width: 5,),
                Text("Add USD", style: TextStyle(color: Colors.white, fontSize: 20),)
              ],
            ),
            onPressed: ()  {
              showAlert(context);
            },

          ),
          SizedBox(height:3,),
          RaisedButton(
            color: Color.fromRGBO(52, 68, 111, 0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),),
            child: Row(
              children: [
                Icon(Iconsax.key, color: Colors.white, size: 30,),
                SizedBox(width: 5,),
                Text("Change password", style: TextStyle(color: Colors.white, fontSize: 20),)
              ],
            ),
            onPressed: ()  {
              showChangePassWord(context);
            },

          ),
          SizedBox(height:3,),
          RaisedButton(
            color: Color.fromRGBO(52, 68, 111, 0.5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),),
            child: Row(
              children: [
                Icon(Icons.logout, color: Colors.white, size: 30,),
                SizedBox(width: 5,),
                Text("Logout", style: TextStyle(color: Colors.white, fontSize: 20),)
              ],
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text("You are logged out. Please log in again !"),
              ),);
            },

          )
        ],
      ),),
    );
  }

  showAlert(BuildContext context) {
    // Create AlertDialog
    AlertDialog dialog = AlertDialog(
      title: Text("Add money"),
      content: Text("Enter the amount you want to add"),
      actions: [
        SingleChildScrollView(
    child: TextField(
          style: TextStyle(color: Colors.black45),
          controller: addMoney,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            prefixIcon: Icon(Iconsax.dollar_circle),
            suffixText: "\$",
            enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.indigoAccent)),
            labelText: "Money",
            labelStyle: TextStyle(color: Colors.black45)
          ),
        ),),
        ElevatedButton(
            child: Text("Ok"),
            onPressed: (){
              Database db = Database();
              final docs = firestore.collection("Wallet").where("uid", isEqualTo: _auth.currentUser!.uid).get()
                  .then((snapshot) {
                final List list = snapshot.docs[0].get("coins");
                List<CoinData> coinDatas = list.map((model) =>
                    CoinData.fromJson(model)).toList();
                List<Map> coins = [];
                for(CoinData i in coinDatas) {
                  coins.add(i.toMap());
                }
                double newMoney = snapshot.docs[0].get("money") + double.parse(addMoney.text);
                db.update(coins, snapshot.docs[0].id, newMoney);
                  });
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

  showChangePassWord(BuildContext context) {
    AlertDialog dialog = AlertDialog(
      title: Text("Change Password"),
      actions: [
        TextField(
          style: TextStyle(color: Colors.black45),
          controller: newPass,
          obscureText: true,
          decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.key4),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigoAccent)),
              labelText: "New password",
              labelStyle: TextStyle(color: Colors.black45)
          ),
        ),
        TextField(
          style: TextStyle(color: Colors.black45),
          controller: confirmPass,
          obscureText: true,
          decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.key5),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigoAccent)),
              labelText: "Confirm new password",
              labelStyle: TextStyle(color: Colors.black45)
          ),
        ),
        ElevatedButton(
            child: Text("Ok"),
            onPressed: (){
              if(newPass.text == confirmPass.text) {
                changePassword(newPass.text);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.redAccent,
                  content: Text("Confirm password is incorrect !"),
                ),);
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

  changePassword(String newPassword) async {
    try{
      await _auth.currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.lightGreen,
        content: Text("Your password has been changed. Login again !"),
      ),);
    } catch(e) {
      print(e);
    }
  }
}
