import 'package:atomic/main.dart';
import 'package:atomic/ui/screen/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/ui/component.dart';
import '/ui/screen/detail_wallet.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _imgPath = 'assets/images/atomic.png';

  Future<User?> login(
      {required String username, required String password, required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
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
                      prefixIcon: Icon(Icons.password, color: Colors.white,),
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
                      User? user = await login(username: _emailController.text,
                          password: _passwordController.text,
                          context: context);
                      if(user == null) {
                        showMyAlertDialog(context);
                      }
                      if (user != null) {
                        print(user);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => MainApp()));
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

  showMyAlertDialog(BuildContext context) {
    // Create AlertDialog
    AlertDialog dialog = AlertDialog(
      title: Text("Error"),
      content: Text("User or password is not correct!"),
      actions: [
        ElevatedButton(
            child: Text("Continue"),
            onPressed: (){
              Navigator.of(context).pop(); // Return value
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
