import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmers_market/product.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../firebase_options.dart';
import 'myCategories.dart';

class ProductDetails extends StatefulWidget {
  static String Category ;


  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<ProductDetails> {
  List<DocumentSnapshot> documents;
  List<DocumentSnapshot> categories;
  List<DocumentSnapshot> producers;
  List<DocumentSnapshot> images;
  TextStyle myStyle = TextStyle(fontFamily: 'Gotham', fontSize: 10);
  TextStyle myStyleSmall =
  TextStyle(fontFamily: 'Gotham', fontSize: 8, color: Colors.pink[600]);
  final _minpadding = 5.0;
  String Category;
  var vege;
  var vege2;

  String type;
  Future<void> getData2() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    vege = await FirebaseFirestore.instance.collection('Categories').doc
      (Category).collection("Items").doc
      (type).collection("Producers");

    final doc = await vege.get();
    producers=doc.docs;
    product.category=Category;
    product.documents=producers;
    product.type = type;
    vege2 = await FirebaseFirestore.instance.collection('Categories').doc
      (Category).collection("Items").doc
      (type).collection("Producers").doc(product.documents[0].id).collection("Images");
     final doc2 = await vege2.get();
     images = doc2.docs;
     print("222222222222222");
     print(images.length);
     product.image = images;
  }
  Future<void> getData() async {
     Category=ProductDetails.Category;
    print("Hello");
    print(Category);

    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    FirebaseFirestore db;
    db = FirebaseFirestore.instance;
    db.settings = const Settings(persistenceEnabled: false);
    final userDocRef = FirebaseFirestore.instance.collection('Categories');
    final doc = await userDocRef.get();
    documents=doc.docs;
    final userDocRef2=FirebaseFirestore.instance.collection('Categories').doc
      (Category).collection("Items");
    final doc2=await userDocRef2.get();
    categories=doc2.docs;
    print(categories);
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: Stack(children: [
          Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Container(
                  child: FutureBuilder<void>(
                      future:  getData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<void> snapshot) {
                        List<Widget> children;

                        if (documents != null) {
                          children = <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: _minpadding * 3,
                                  bottom: _minpadding * 3,
                                  left: _minpadding * 2),
                              child: Text(
                                'Top Products',
                                style: myStyle,
                              ),
                            ),
                            myCategories(documents),

                            Text("    ", style: TextStyle(fontSize: 20)),

                            Text("  ", style: TextStyle(fontSize: 4)),
                            Container(
                                height: 70.0 * categories.length,
                                child: ListView.builder(itemCount: categories.length,
                                    itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                      onTap: () async {
                                         type = categories[index].id;
                                        await getData2();

                                        product.producers=vege;
                                        product.selectedIndex=0;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(

                                              builder: (context) => product()),
                                        );

                                      },
                                      title: Text(categories[index].id),
                                      dense: true,
                                      visualDensity: VisualDensity(vertical: 4),
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        //add border radius here
                                        child: Image.network(
                                        categories[index].get("img"), //add
                                        // image
                                  // location
                                  // here
                                      )),



                                  );
                                })
                            )];
                        } else {
                          children = const <Widget>[
                            Center(
                                child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: CircularProgressIndicator(),
                                )),
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text('Awaiting result...'),
                            )
                          ];
                        }
                        return Column(children: children);
                      }),
                ),
              ))
        ]),
        onRefresh: () {
          return Future.delayed(Duration(seconds: 1), () {
            setState(() {});
          });
        });
  }
  
}
  

