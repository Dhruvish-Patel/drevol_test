// Couldn't established the way in which the user can directly go to the home page.
// I am not familiar to the concept of this. Though I tried it using firebase but it isn't working.
// There might be some error in my logic.

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Container(
                  child: Image.asset('assets/images/flutter_logo.png'),
                  height: 80.0,
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                'Flutter',
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 70.0,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _email,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Name',
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _password,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            onPressed: () async {
              try {
                UserCredential userCredential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: _email.text, password: _password.text);
                Fluttertoast.showToast(
                    msg: 'Login Successful',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.white24,
                    textColor: Colors.black,
                    fontSize: 18.0);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  Fluttertoast.showToast(
                      msg: 'No such user found',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.white24,
                      textColor: Colors.black,
                      fontSize: 18.0);
                } else if (e.code == 'wrong-password') {
                  Fluttertoast.showToast(
                      msg: 'Password didn\'t matched',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.white24,
                      textColor: Colors.black,
                      fontSize: 18.0);
                }
              }
            },
            color: Colors.black54,
            child: Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
