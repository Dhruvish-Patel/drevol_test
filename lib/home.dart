// Sorry couldn't get all the functionalities demanded in the assignment
// Searchbar and sorting is remaining in the code

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: Icon(
          Icons.menu,
        ),
        title: Text(
          'Home',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app_rounded),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              })
        ],
      ),
      body: Center(
        child: FutureBuilder(
          builder: (context, snapshot) {
            var showData = json.decode(snapshot.data.toString());
            showData = showData['users'];
            return ListView.builder(
                itemCount: showData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.face,
                          size: 30.0,
                        ),
                        SizedBox(
                          width: 90.0,
                        ),

                        //Network image couldn't be loaded... I may be wrong in some interpretation.
                        // Image.network(showData[index]['profile_pic']),

                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Name:' + showData[index]['username']),
                              Text('email:' + showData[index]['email']),
                              Text('Primary Contact:' +
                                  showData[index]['contact_numbers'][0]
                                      ['contact_no']),
                              Text('City:' + showData[index]['city']),
                            ])
                      ],
                    ),
                  );
                });
          },
          future: DefaultAssetBundle.of(context)
              .loadString("assets/data/users.json"),
        ),
      ),
    );
  }
}
