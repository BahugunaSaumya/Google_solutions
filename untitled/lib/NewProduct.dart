import 'package:farmers_market/home_screens/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'firebase_options.dart';
import 'logincustomer.dart';
import 'loginfarmer.dart';

void main() {
  runApp(const new_product());
}

class new_product extends StatelessWidget {
  static var user_id;


  static var de;
  static String se;
  static List<DocumentSnapshot> it;
  const new_product({Key key}) : super(key: key);

  static const String _title = 'New product';

  @override
  Widget build(BuildContext context) {
    MyStatelessWidget.user_id=user_id;
    MyStatelessWidget.items = it;
    MyStatelessWidget.decide = de;
    MyStatelessWidget.selectedValue = se;
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: new Text(
            "Add new product",
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
  static var user_id;
  static String selectedValue;
  var changedvalue;
  static var decide;
  static int pass;
  static List<String> categories = new List();
  final _formKey = GlobalKey<FormState>();

  static List<DocumentSnapshot> documents;
  static List<DocumentSnapshot> items;

  Future<void> readExcelFile() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FirebaseFirestore db = FirebaseFirestore.instance;
    print("hello");
    if (selectedValue == null) {
      selectedValue =
          "Select value"; // change value for comapre to function as well on changing this value line- 168 and 233
    }
    if (decide != false) {
      decide = true;
    }


    final result = await db.collection('Categories').get();

    documents = result.docs;
    if (items == null) {
      items = [];
    }
    print(decide);
    print(selectedValue);
  }

  Future<void> getitem() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FirebaseFirestore db = FirebaseFirestore.instance;
    print("hello");



    final result = await db
        .collection('Categories')
        .doc(selectedValue)
        .collection("Items")
        .get();

    items = result.docs;

    print(items.length);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController qty = TextEditingController();

    print(categories);
    return Scaffold(
        body: Form(
            key: _formKey,
            child: FutureBuilder<void>(
                future: readExcelFile(),
                // a previously-obtained Future<String> or null
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  List<Widget> children;
                  if (documents != null) {
                    children = <Widget>[
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 30),
                            DropdownButtonFormField2(
                              decoration: InputDecoration(
                                //Add isDense true and zero Padding.
                                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                //Add more decoration as you want here

                                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                              ),
                              isExpanded: true,
                              hint: Text(
                                selectedValue,
                                style: TextStyle(fontSize: 14),
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 30,
                              buttonHeight: 60,
                              buttonPadding:
                                  const EdgeInsets.only(left: 20, right: 10),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              items: documents
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item.id,
                                        child: Text(
                                          item.id,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              validator: (value) {
                                if (value == null &&
                                    selectedValue.compareTo("Select value") ==
                                        0) {
                                  return 'Please select gender.';
                                }
                              },
                              onChanged: (value) {
                                //Do something when changing the item if you want.
                                selectedValue = value.toString();
                                //  decide = false;
                                print(selectedValue);
                                new_product.de = false;
                                getitem();
                                new_product.it = items;
                                new_product.se = selectedValue;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => new_product()),
                                );
                              },
                              onSaved: (changedvalue) {},
                            ),
                            IgnorePointer(
                                ignoring: decide,
                                child: DropdownButtonFormField2(
                                  decoration: InputDecoration(
                                    //Add isDense true and zero Padding.
                                    //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    //Add more decoration as you want here
                                    //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                  ),
                                  isExpanded: true,
                                  hint: const Text(
                                    'Select Your Item',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black45,
                                  ),
                                  iconSize: 30,
                                  buttonHeight: 60,
                                  buttonPadding: const EdgeInsets.only(
                                      left: 20, right: 10),
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  items: items
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item.id,
                                            child: Text(
                                              item.id,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color:
                                                    decide ? Colors.grey : null,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  validator: (value) {
                                    if (value == null &&
                                        selectedValue
                                                .compareTo("Select value") ==
                                            0) {
                                      return 'Please select gender.';
                                    }
                                  },
                                  onChanged: (value) {
                                    changedvalue = value.toString();
                                    print(changedvalue);
                                  },
                                  onSaved: (value) {},
                                )),
                            const SizedBox(height: 50),

                            TextFormField(
                                controller:qty,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.add),

                                  hintText: 'Enter the amount produced',
                                  labelText: 'Qty *',
                                ),
                            ),

                            const SizedBox(height: 100),
                            TextButton(
                              onPressed: () async {
                                print(user_id);

                                FirebaseFirestore db = FirebaseFirestore.instance;
                                final userDocRef = db.collection("Farmer's Item").doc(user_id).collection(selectedValue).doc(changedvalue);



                                userDocRef.get().then(
                                      (DocumentSnapshot doc) {
                                    final data = doc.data() as Map<String, dynamic>;
                                    pass=data["Qty"];

                                  },
                                  onError: (e) => print("Error getting document: $e"),
                                );
                                final Qty=<String, int>{
                                  "Qty":(5),
                                };
                                userDocRef.set(Qty)
                                    .onError((e, _) => print("Error writing document: $e"));
                                }
                              ,
                              child: const Text('Submit'),
                            ),
                          ])
                    ];
                  } else {
                    children = const <Widget>[
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Awaiting result...'),
                      )
                    ];
                  }

                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: children,
                    ),
                  );
                })));
  }
}

