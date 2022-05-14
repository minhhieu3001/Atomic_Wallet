import 'package:atomic/ui/screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                    if(_passwordController.text != _confirmPasswordController.text) {
                      showMyAlertDialog(context);
                    } else {
                      if (_formKey.currentState != null) {
                        _signUp();
                      }
                    }
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
      });
    } on FirebaseAuthException catch(e) {
      print("exception");
    }

  }

  showMyAlertDialog(BuildContext context) {
    // Create AlertDialog
    AlertDialog dialog = AlertDialog(
      title: Text("Error"),
      content: Text("Confirmation password is different from password!"),
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
