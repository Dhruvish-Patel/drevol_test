import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'home.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drevol Test',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool user = false;

  @override
  void initState() {
    super.initState();
    user = checkUser();
    Timer(
        Duration(seconds: 5),
        () => {
              if (user)
                {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()))
                }
              else
                {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Login()))
                }
            });
  }

  bool checkUser() {
    bool flag = false;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        flag = false;
      } else {
        flag = true;
      }
    });
    return flag;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Hero animation can work only if the height mentioned is different.
            //I kept same height because due to text available the aesthetics were not looking good

            Hero(
              tag: 'logo',
              child: Container(
                child: Image.asset('assets/images/flutter_logo.png'),
                height: 80.0,
              ),
            ),
            SizedBox(width: 8.0),
            TypewriterAnimatedTextKit(
              text: ['Flutter'],
              textStyle: TextStyle(
                fontSize: 40.0,
                color: Colors.black,
              ),
              speed: Duration(milliseconds: 110),
            ),
          ],
        ),
      ),
    );
  }
}
