import 'dart:collection';

import 'package:atomic/ui/screen/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../model/CoinData.dart';
import '../../model/Wallet.dart';
import '/ui/component.dart';
import '/ui/screen/detail_wallet.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _imgPath = 'assets/images/atomic.png';
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(32, 43, 71, 1),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100,),
              Center(child: Image.asset(_imgPath, width: 200,),),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.mail, color: Colors.white,),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.white)

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.password, color: Colors.white,),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.white)

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.password, color: Colors.white,),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      labelText: "Confirm password",
                      labelStyle: TextStyle(color: Colors.white)

                  ),
                ),
              ),
              Container(margin: EdgeInsets.fromLTRB(0, 20, 0, 0),child: SizedBox(
                height: 60,
                width: 300,
                child: RaisedButton(color: const Color.fromRGBO(27, 142, 249, 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  onPressed: (){
                  if(_confirmPasswordController.text != _passwordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text( "Confirmation password is different from password. Try again"),
                    ),);
                  }
                    _signUp();
                  },
                  child: const Text("SIGN UP", style: TextStyle(color: Colors.white, fontSize: 20),),
                ),
              ),),
            ],
          ),
        ),
      ),
    );
  }

  Future _signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text)
      .then((value) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => LoginPage()));
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        FirebaseAuth _auth = FirebaseAuth.instance;
        CollectionReference reference = firestore.collection("Wallet");
        List<Map> coins = [];
        reference.add({"uid": _auth.currentUser!.uid, "coins": coins, "money": 0}).then((value) => print("Add dc"));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text( "Sign up success !"),
        ),);

      });
    } on FirebaseAuthException catch(e) {
      String errMsg = "";
      switch(e.code) {
        case 'email-already-in-use':
          errMsg = "This Email ID already Associated with Another Account.";
          break;
        case 'invalid-email':
          errMsg = 'Your email address appears to be malformed.';
          break;
        case 'wrong-password':
          errMsg = 'Your password is wrong.';
          break;
        case 'user-not-found':
          errMsg = "User with this email doesn't exist.";
          break;
        case 'user-disabled':
          errMsg = 'User with this email has been disabled.';
          break;
        case 'too-many-requests':
          errMsg = 'Too many requests';
          break;
        case 'operation-not-allowed':
          errMsg = 'Signing in with Email and Password is not enabled.';
          break;
      }
      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text( errMsg + " Try again"),
      ),);
    }
  }
}
