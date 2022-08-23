import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'logincustomer.dart';
import 'loginfarmer.dart';

void main() {
  runApp(const new_farmers());
}

class new_farmers extends StatelessWidget {
  const new_farmers({Key key}) : super(key: key);

  static const String _title = 'New Farmer';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: new Text(
            "New Farmers",
            style: new TextStyle(color: Colors.white),
          ),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => loginFarmer()),
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
  final name = TextEditingController();

  final email = TextEditingController();

  final phone = TextEditingController();

  final address = TextEditingController();

  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> create() async {
      FirebaseFirestore db = FirebaseFirestore.instance;
      db.settings = const Settings(persistenceEnabled: false);

      final userDocRef = db.collection("Farmer's Item").doc(email.text);
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
        final farmer = <String, String>{
          "Name": name.text,
          "Email": email.text,
          "Phone": phone.text,
          "Address": address.text,
          "Password": password.text
        };
        db
            .collection("Farmer's Item")
            .doc(email.text)
            .set(farmer)
            .onError((e, _) {
          print("Error writing document: $e");
        });
      }
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => loginFarmer()));
    }

    CollectionReference customers =
        FirebaseFirestore.instance.collection("Farmer's Item");
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
            onFieldSubmitted: (String text) {},
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
            onFieldSubmitted: (String text) {},
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
            onFieldSubmitted: (String text) {},
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
            onFieldSubmitted: (String text) {},
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
            onFieldSubmitted: (String text) {
              create();
            },
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
                  create();
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
