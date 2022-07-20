import 'package:farmers_market/home_screens/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'logincustomer.dart';
import 'loginfarmer.dart';

void main() {
  runApp(const new_customer());
}

class new_customer extends StatelessWidget {
  const new_customer({Key key}) : super(key: key);

  static const String _title = 'New Customer';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: new Text(
            "New Customer",
            style: new TextStyle(color: Colors.white),
          ),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => loginCustomer()),
              );
            },
          ),
        ),
        body: MyStatelessWidget(),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference customers =
        FirebaseFirestore.instance.collection('Customers');
    return ListView(padding: const EdgeInsets.all(8), children: <Widget>[
      Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: name,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Name',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: email,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Email id',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: phone,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Phone no',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: address,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Address',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: password,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Password',
            ),
          ),
        ),
        const SizedBox(height: 40),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(15.0),
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () async {
                  FirebaseFirestore db = FirebaseFirestore.instance;
                  db.settings = const Settings(persistenceEnabled: false);

                  final userDocRef = db.collection('Customers').doc(email.text);
                  final doc = await userDocRef.get();
                  if (doc.exists) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          // Retrieve the text the that user has entered by using the
                          // TextEditingController.
                          content: Text("Email Already exist! Try logging in "),
                        );
                      },
                    );
                  } else {
                    final customer = <String, String>{
                      "Name": name.text,
                      "Email": email.text,
                      "Phone": phone.text,
                      "Address": address.text,
                      "Password": password.text
                    };
                    db
                        .collection("Customers")
                        .doc(email.text)
                        .set(customer)
                        .onError((e, _) {
                      print("Error writing document: $e");
                    });
                  }
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => loginCustomer()));
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ])
    ]);
  }
}
