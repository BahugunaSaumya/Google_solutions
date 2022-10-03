import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmers_market/product.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../firebase_options.dart';
import 'myCategories.dart';



class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  TextStyle myStyle = TextStyle(fontFamily: 'Gotham', fontSize: 10);
  TextStyle myStyleSmall =
      TextStyle(fontFamily: 'Gotham', fontSize: 8, color: Colors.pink[600]);
  final _minpadding = 5.0;

  Widget imageCarousel = Container(
    height: 170,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withOpacity(0.6),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(2, 0), // changes position of shadow
        ),
      ],
    ),
    child: Carousel(
      boxFit: BoxFit.cover,
      images: [
        AssetImage('images/image1.jpg'),
        AssetImage('images/image2.jpg'),
        AssetImage('images/image3.jpg'),
        AssetImage('images/image4.jpg'),
      ],
      dotSize: 4.0,
      dotSpacing: 15.0,
      dotColor: Colors.pink[300],
      indicatorBgPadding: 5.0,
      autoplay: true,
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(milliseconds: 3000),
    ),
  );

  static List<DocumentSnapshot> documents;
  static List<DocumentSnapshot> recent;
  Future<void> readExcelFile() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    FirebaseFirestore db = FirebaseFirestore.instance;
    db.settings = const Settings(persistenceEnabled: false);
    final result = await db.collection('Categories').get();
    
    documents = result.docs;
    
    final items = await db.collection("Recent items").get();
    recent = items.docs;


    print(recent.length);
  }
  List<DocumentSnapshot> categories;
  List<DocumentSnapshot> producers;
  List<DocumentSnapshot> images;
  var vege,vege2;
  Future<void> readImage(String Category,String type,String producer) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    vege = await FirebaseFirestore.instance.collection('Categories').doc
      (Category).collection("Items").doc
      (type).collection("Producers");

    final doc = await vege.get();
    producers=doc.docs;
    int c=0;
    for(var i in producers)
      {
        if(i.id.compareTo(producer)==0)
          {
            product.selectedIndex=c;
          }
        c++;
      }

    product.category=Category;
    product.documents=producers;
    product.type = type;
    vege2 = await FirebaseFirestore.instance.collection('Categories').doc
      (Category).collection("Items").doc
      (type).collection("Producers").doc(producer).collection("Images");
    final doc2 = await vege2.get();
    images = doc2.docs;
    product.producers=vege;
    print(images.length);
    product.image = images;
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
                      future: readExcelFile(),
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
                            // Recent Items start here
                            Text("    ", style: TextStyle(fontSize: 20)),
                            imageCarousel,
                            Text("  ", style: TextStyle(fontSize: 4)),
                            Container(
                                height: 300,
                                child: GridView.builder(

                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 0.80,
                                          crossAxisCount: 3),
                                  itemCount: recent.length,
                                  itemBuilder:
                                      (BuildContext context, int index) => Card(
                                    elevation: 0,
                                    color: Colors.transparent,
                                    shape: CircleBorder(),
                                    //  borderRadius: BorderRadius.all(Radius.circular(100))),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () async {
                                        await readImage(recent[index].get
                                          ("Collection"),recent[index].get
                                          ("Item"),recent[index].get
                                          ("Producer"));
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => product()),
                                        );
                                        Fluttertoast.showToast(
                                            msg:
                                                recent[index].id + " Tapped",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 2,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white,
                                            fontSize: 14.0);
                                      },
                                      child: Column(

                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[

                                          Container(

                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.deepPurple
                                                        .withOpacity(0.4),
                                                    spreadRadius: 4,
                                                    blurRadius: 8,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                                color: Colors.transparent,
                                                border: Border.all(
                                                  color: Color.fromARGB(
                                                      255, 203, 126, 216),
                                                  width: .8,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30.0))),
                                            height: 90,
                                            width: 90,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),

                                              //radius: 49,
                                              //backgroundImage: NetworkImage(
                                              child: FadeInImage.memoryNetwork(
                                                placeholder: kTransparentImage,
                                                image:
                                                    recent[index].get("Img"),

                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "  ",
                                            style: TextStyle(fontSize: 6),
                                          ),
                                          Expanded(child: Text(recent[index].get("Item") +
                                              "\n" + "Farmer:\n" +
                                              recent[index].get("Name"),
                                              style: TextStyle(fontSize: 12))),


                                        ],
                                      ),
                                    ),
                                  ),
                                ))
                          ];
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
