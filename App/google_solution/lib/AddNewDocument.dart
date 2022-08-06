import 'package:farmers_market/NewProduct.dart';
import 'package:farmers_market/home_screens/main_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';
import 'logincustomer.dart';
import 'loginfarmer.dart';

class AddNewDocument extends StatelessWidget {
  Future<void> initialize() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  static var user;
  static var cate;

  final Item = TextEditingController();
  final Qty = TextEditingController();
  final user_id = user;
  final category = cate;
  final url = TextEditingController();
  //final category = TextEditingController();
  @override
  Widget build(BuildContext context) {
    initialize();
    CollectionReference customers =
        FirebaseFirestore.instance.collection("Farmer's Items");

    return Material(
        child: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
      Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: Item,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Item',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: Qty,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Qty',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: url,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Please add an image url',
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
                  if (Item.text == "" || Qty.text == "") {
                    showAlertDialog(context);
                  } else {
                    final result = await db
                        .collection("Farmer's Item")
                        .doc(user_id)
                        .collection(category)
                        .doc(Item.text)
                        .set({'Qty': int.parse(Qty.text), 'img': url.text});

                    db
                        .collection("Categories")
                        .doc(category)
                        .collection("Items")
                        .doc(Item.text)
                        .set({'Qty': Qty.text, 'img': url.text});
                    db
                        .collection("Categories")
                        .doc(category)
                        .collection("Items")
                        .doc(Item.text)
                        .collection("Producers")
                        .doc(user_id)
                        .set({'Qty': Qty.text, 'img': url.text});

                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => new_product()));
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ])
    ]));
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {},
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("ALERT"),
    content: Text("Please Fill Details"),
    actions: [],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
