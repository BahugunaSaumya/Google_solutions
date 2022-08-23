import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmers_market/home_screens/farmers_home_screen.dart';
import 'package:farmers_market/home_screens/main_view.dart';
import 'package:farmers_market/new_farmers.dart';
import 'package:flutter/material.dart';

import 'NewProduct.dart';
import 'new_customer.dart';
import 'landing.dart';

void main() {
  runApp(const loginFarmer());
}

class loginFarmer extends StatelessWidget {
  const loginFarmer({Key key}) : super(key: key);

  static const String _title = 'Blah Blah Blah';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: new Text(
            "Farmer Login",
            style: new TextStyle(color: Colors.white),
          ),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => landing()),
              );
            },
          ),
        ),
        body: MyStatelessWidget(),
      ),
    );
  }
}

class MyStatelessWidget extends StatefulWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  State<MyStatelessWidget> createState() => _MyStatelessWidgetState();
}

class _MyStatelessWidgetState extends State<MyStatelessWidget> {
  Future<void> login() async {
    FirebaseFirestore db;
    db = FirebaseFirestore.instance;
    final userDocRef = FirebaseFirestore.instance
        .collection("Farmer's Item")
        .doc(myController1.text);
    final doc = await userDocRef.get();
    if (!doc.exists) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // Retrieve the text the that user has entered by using the
            // TextEditingController.
            content: Text("Account doesn't exist! "),
          );
        },
      );
    } else {
      final docRef = db.collection("Farmer's Item").doc(myController1.text);

      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          String pass = data["Password"];
          print(pass);
          if (pass.compareTo(myController2.text) == 0) {
            new_product.user_id = myController1.text;
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => farmers_home_screen()));
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  // Retrieve the text the that user has entered by using the
                  // TextEditingController.
                  content: Text("Wrong Password "),
                );
              },
            );
          }
        },
        onError: (e) => print("Error getting document: $e"),
      );
    }
  }

  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 30),
            Container(
                width: 180.0,
                height: 30.0,
                child: TextField(
                  controller: myController1,
                  obscureText: false,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 15.0, height: 1.0, color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(7.0, 9.0, 7.0, 9.0),
                    labelText: 'Username',
                  ),
                )),
            const SizedBox(height: 20),
            Container(
                width: 180.0,
                height: 30.0,
                child: TextField(
                  controller: myController2,
                  maxLines: 1,
                  obscureText: true,
                  style: TextStyle(
                      fontSize: 15.0, height: 1.0, color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(7.0, 9.0, 7.0, 9.0),
                    labelText: 'Password',
                  ),
                  onSubmitted: (String text) {
                    login();
                  },
                )),
            const SizedBox(height: 100),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF0DA155),
                            Color(0xFF19D2A1),
                            Color(0xFF42F581),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      primary: Colors.white,
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: () async {
                      login();
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                primary: Colors.blue,
                textStyle: const TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => new_farmers()),
                );
              },
              child: const Text('Create a new account'),
            ),
          ],
        ),
      ),
    );
  }
}
