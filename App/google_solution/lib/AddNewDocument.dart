import 'dart:io';

import 'package:farmers_market/NewProduct.dart';
import 'package:farmers_market/home_screens/farmers_home_screen.dart';
import 'package:farmers_market/home_screens/main_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'firebase_options.dart';
import 'logincustomer.dart';
import 'loginfarmer.dart';

class AddNewDocument extends StatefulWidget {
  static var user;
  static var cate;
  static final user_id = new_product.user_id;

  static final category = new_product.se;

  @override
  State<AddNewDocument> createState() => _AddNewDocumentState();
}
List images=[];
List imagesRef=[];
final user_id = AddNewDocument.user_id;

final category = AddNewDocument.category;
class _AddNewDocumentState extends State<AddNewDocument> {
  Future<void> initialize() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  final Item = TextEditingController();
  final Qty = TextEditingController();

  final url = TextEditingController();


  //final category = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(category);
    print("------------------");
    print(user_id);

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
              child: Text(
                "Select One or more images",

                style: const TextStyle(color:Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize:18,
                ),



            )),
            const SizedBox(height: 10),
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
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(15.0),
                      primary: Colors.white,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
                        await getFiles();
                    },
                    child: const Text('Select',
                        textAlign: TextAlign.left),

                  ),
                ],
              ),
            ),
            SizedBox(height: 200,
              child: ListView.builder(itemCount:images.length,itemBuilder:
                  (BuildContext
              context, int index) {
                return ListTile(
                  title: Text("Image"+(index).toString()),
                );
              } ),
            ),

            const SizedBox(height: 100),
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
                      await uploadFile();

                      print(category);
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
                            .set({'Qty': int.parse(Qty.text), 'img': url.text});
                        db
                            .collection("Categories")
                            .doc(category)
                            .collection("Items")
                            .doc(Item.text)
                            .collection("Producers")
                            .doc(user_id)
                            .set({'Qty': int.parse(Qty.text), 'img': url.text});

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => farmers_home_screen()));
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
  ImagePicker _picker = ImagePicker();
  PlatformFile pickedFile;
  Future getFiles() async{
    final selectFile = await _picker.getImage(source: ImageSource.gallery);

    setState((){
      images.add(File(selectFile.path));
    });

}
  Future uploadFile() async
  {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    for(var img in images)
      {

        var ref = FirebaseStorage.instance.ref().child('images/${(basename(img
            .path))}');
        await ref.putFile(img).whenComplete(() async{
          await ref.getDownloadURL().then((value){
            imagesRef.add(value);
          });
        });
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


}