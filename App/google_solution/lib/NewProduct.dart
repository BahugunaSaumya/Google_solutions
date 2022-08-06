import 'package:farmers_market/AddNewDocument.dart';
import 'package:farmers_market/home_screens/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'firebase_options.dart';
import 'logincustomer.dart';
import 'loginfarmer.dart';

class new_product extends StatefulWidget {
  static var user_id;

  static var de;
  static String se;

  const new_product({Key key}) : super(key: key);

  static const String _title = 'New product';

  @override
  State<new_product> createState() => _new_productState();
}

class _new_productState extends State<new_product> {
  final GlobalKey<FormFieldState> _key = GlobalKey<FormFieldState>();
  String changedvalue = "";
  String selectedValue = "";

  static var userDocRef;
  String decide;
  static DocumentSnapshot docs;
  static var user_id = new_product.user_id;

  List<DocumentSnapshot> documents = [];
  final _formKey = GlobalKey<FormFieldState>();
  int pass;
  static var data;
  List<DocumentSnapshot> items = [];

  Future<void> readExcelFile() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    documents.clear();
    FirebaseFirestore db = FirebaseFirestore.instance;

    final result = await db.collection('Categories').get();

    documents = result.docs;
    if (items == null) {
      items = [];
    }
  }

  Future<void> getvalue() async {
    data = docs.data() as Map<String, dynamic>;
    print(data);
    pass = data["Qty"];
  }

  static List temp = new List();
  Future<void> checkvalue() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FirebaseFirestore db = FirebaseFirestore.instance;

    final result = await db
        .collection("Farmer's Item")
        .doc(user_id)
        .collection(selectedValue)
        .doc(changedvalue)
        .set({'Qty': 0});

    print(selectedValue);
    print(changedvalue);
    print("duck");
    print(temp);
    if (temp == []) {
      /*Fluttertoast.showToast(
          msg: "No such category exist in your Database",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 14.0);*/
      showAlertDialog(context);
      db
          .collection("Farmer's Item")
          .doc(user_id)
          .collection(selectedValue)
          .doc(changedvalue)
          .set({'Qty': 0});
    }
  }

  Future<void> getitem() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FirebaseFirestore db = FirebaseFirestore.instance;
    items.clear();
    final result = await db
        .collection('Categories')
        .doc(selectedValue)
        .collection("Items")
        .get();

    items = result.docs;

    print("hello");
  }

  @override
  TextEditingController qty = TextEditingController();
  TextEditingController url = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
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
                                "Select a category",
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
                                  return 'Please select value.';
                                }
                              },
                              onChanged: (value) {
                                //Do something when changing the item if you want.

                                //  decide = false;
                                print(selectedValue);
                                new_product.de = false;
                                getitem();

                                new_product.se = selectedValue;
                                setState(() {
                                  selectedValue = value.toString();
                                  reset();
                                });
                              },
                              //onSaved: () {},
                            ),
                            Text(
                              " ",
                              style: TextStyle(fontSize: 19),
                            ),
                            IgnorePointer(
                                ignoring: false,
                                child: DropdownButtonFormField2(
                                  key: _key,
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
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  validator: (value) {
                                    if (value == null &&
                                        selectedValue
                                                .compareTo("Select value") ==
                                            0) {
                                      return 'Please select value';
                                    }
                                  },
                                  onChanged: (value) {
                                    changedvalue = value.toString();

                                    checkvalue();
                                    print(changedvalue);
                                  },
                                  onSaved: (value) {},
                                )),
                            const SizedBox(height: 50),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: qty,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.add),
                                hintText: 'Enter the amount produced',
                                labelText: 'Qty *',
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: url,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.add),
                                hintText:
                                    'Enter a url of an image related to the product',
                                labelText: 'Url',
                              ),
                            ),
                            const SizedBox(height: 100),
                            TextButton(
                              onPressed: () async {
                                if (changedvalue.compareTo("") == 0) {
                                  showAlertDialog(context);
                                } else {
                                  print(user_id);

                                  final docRef = await FirebaseFirestore
                                      .instance
                                      .collection("Categories")
                                      .doc(selectedValue)
                                      .collection("Items")
                                      .doc(changedvalue);
                                  int temp = 0;
                                  await docRef.get().then(
                                    (DocumentSnapshot doc) {
                                      final data =
                                          doc.data() as Map<String, dynamic>;
                                      temp = temp + data["Qty"];
                                    },
                                    onError: (e) =>
                                        print("Error getting document: $e"),
                                  );
                                  temp = int.parse(qty.text) + temp;
                                  FirebaseFirestore.instance
                                      .collection("Categories")
                                      .doc(selectedValue)
                                      .collection("Items")
                                      .doc(changedvalue)
                                      .set({"Qty": temp});
                                  final docRef2 = await FirebaseFirestore
                                      .instance
                                      .collection("Categories")
                                      .doc(selectedValue)
                                      .collection("Items")
                                      .doc(changedvalue)
                                      .collection("Producers")
                                      .doc(user_id);
                                  temp = 0;
                                  await docRef2
                                      .get()
                                      .then((DocumentSnapshot doc) {
                                    if (doc.exists) {
                                      final data =
                                          doc.data() as Map<String, dynamic>;
                                      temp = int.parse(qty.text) + data["Qty"];
                                      FirebaseFirestore.instance
                                          .collection("Categories")
                                          .doc(selectedValue)
                                          .collection("Items")
                                          .doc(changedvalue)
                                          .collection("Producers")
                                          .doc(user_id)
                                          .set({'Qty': temp});
                                    } else
                                      FirebaseFirestore.instance
                                          .collection("Categories")
                                          .doc(selectedValue)
                                          .collection("Items")
                                          .doc(changedvalue)
                                          .collection("Producers")
                                          .doc(user_id)
                                          .set({'Qty': int.parse(qty.text)});
                                  });
                                  userDocRef = await FirebaseFirestore.instance
                                      .collection("Farmer's Item")
                                      .doc(user_id)
                                      .collection(selectedValue)
                                      .doc(changedvalue);
                                  if (qty.text == "") {
                                    showAlertDialog(context);
                                  } else {
                                    await userDocRef.get().then(
                                      (DocumentSnapshot doc) {
                                        final data =
                                            doc.data() as Map<String, dynamic>;
                                        print(data);
                                        pass = data["Qty"];
                                      },
                                      onError: (e) =>
                                          print("Error getting document: $e"),
                                    );
                                    print(pass);

                                    //await userDocRef.set(Qty);
                                    await userDocRef.set({
                                      "Qty": int.parse(qty.text) + pass,
                                      "img": url.text
                                    });
                                  }
                                }
                              },
                              child: const Text('Submit'),
                            ),
                            const SizedBox(height: 50),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                primary: Colors.blue,
                                textStyle: const TextStyle(fontSize: 16),
                              ),
                              onPressed: () {
                                AddNewDocument.user = user_id;
                                if (selectedValue == "") {
                                  showAlertDialog(context);
                                } else {
                                  AddNewDocument.cate = selectedValue;

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddNewDocument()),
                                  );
                                }
                              },
                              child: const Text('Create a new item'),
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

  reset() {
    _key.currentState.reset();
  }
}
// removable code

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {},
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("ALERT"),
    content: Text("Please Select a Category First"),
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
