import 'package:atomic/main.dart';
import 'package:atomic/ui/screen/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '/ui/component.dart';
import '/ui/screen/detail_wallet.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _imgPath = 'assets/images/atomic.png';
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> login(
      {required String username, required String password, required BuildContext context}) async {
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: username, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("no user found for that username");
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Color.fromRGBO(32, 43, 71, 1),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Center(
                child: Image.asset(
                  _imgPath,
                  width: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.mail, color: Colors.white,),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.white)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.key1, color: Colors.white,),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.white)),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: SizedBox(
                  height: 60,
                  width: 300,
                  child: RaisedButton(
                    color: const Color.fromRGBO(27, 142, 249, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    onPressed: () async {
                      try {
                        await auth.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text)
                          .then((value) => {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => MainApp(uid: auth.currentUser!.uid )))
                          });
                      } on FirebaseAuthException catch (error) {
                        String errMsg= '';
                        switch(error.code) {
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
                          default:
                            errMsg = 'An undefined Error happened.';
                        }
                        await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text( errMsg + " Try again"),
                        ),);
                      }
                      },
                    child: const Text(
                      "LOGIN",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Center(
                  child: Text(
                    "Have not had account yet?",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Center(
                  child: GestureDetector(
                    child: Text("Sign up here",
                      style: TextStyle(color: Colors.redAccent, fontSize: 15),),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage()
                          )
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
