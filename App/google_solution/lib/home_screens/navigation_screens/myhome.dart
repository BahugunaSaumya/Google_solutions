import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmers_market/product.dart';
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
  static List list = new List();
  static List<DocumentSnapshot> documents;
  Future<void> readExcelFile() async {

    final result =
        await FirebaseFirestore.instance.collection('Categories').get();
   
    documents = result.docs;
 
    print(documents.length);
    int count = 1;
    for (DocumentSnapshot data in documents) {
      List temp = new List();
      temp.add(count);
      temp.add(data.id.toString());
      temp.add(data.get("img").toString());
      
      list.add(temp);
      count++;
    }
    
    /*userDocRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        print(data);
      },
      onError: (e) => print("Error getting document: $e"),
    );*/
    // print(res);
    // List list = new List();
/*
    ByteData data = await rootBundle.load("Categories.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table].rows) {
        list.add(row);
      }
    }*/
  }

  @override
  Widget build(BuildContext context) {
    // var file = await rootBundle.load("assets/$fileName");
    // var bytes = File(file).readAsBytesSync();
    // var excel = Excel.decodeBytes(bytes);

    readExcelFile();
    /*list = [
      [
        1,
        "Dairy",
        "https://www.dairyfoods.com/ext/resources/DF/2020/August/df-100/GettyImages-1194287257.jpg?1597726305"
      ],
      [
        2,
        "TTTTT",
        "https://www.dairyfoods.com/ext/resources/DF/2020/August/df-100/GettyImages-1194287257.jpg?1597726305"
      ]
    ];
*/
    {
      ;
      return Stack(children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Container(
              child: Column(children: <Widget>[
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
                SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: (context, index) => Card(
                      elevation: 0,
                      color: Colors.transparent,
                      shape: CircleBorder(),
                      //  borderRadius: BorderRadius.all(Radius.circular(100))),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          product.li = list;
                          product.he = list[index][1];
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => product()),
                          );
                          Fluttertoast.showToast(
                              msg: documents[index].id + " Tapped",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 14.0);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            /*    FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                fit: BoxFit.cover,
                                height: 90,
                                width: 150,
                                image: list[index][2]),*/
                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.deepPurple.withOpacity(0.4),
                                      spreadRadius: 3,
                                      blurRadius: 8,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  radius: 51,
                                  backgroundColor:
                                      Color.fromARGB(255, 203, 126, 216),
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                      list[index][2],
                                    ),
                                  ),
                                )),
                            Text(
                              " ",
                              style: TextStyle(fontSize: 3),
                            ),
                            Text(list[index][1], style: TextStyle(fontSize: 14))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Text("    ", style: TextStyle(fontSize: 20)),
                imageCarousel,
                Text("  "),
                Container(
                    height: 300,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) => Card(
                        elevation: 0,
                        color: Colors.transparent,
                        shape: CircleBorder(),
                        //  borderRadius: BorderRadius.all(Radius.circular(100))),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            product.li = list;
                            product.he = list[index][1];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => product()),
                            );
                            Fluttertoast.showToast(
                                msg: list[index][1] + " Tapped",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 14.0);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              /*    FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                fit: BoxFit.cover,
                                height: 90,
                                width: 150,
                                image: list[index][2]),*/
                              Container(
                                //radius: 50,
                                //backgroundColor: Colors.blueGrey,

                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.deepPurple.withOpacity(0.4),
                                        spreadRadius: 2,
                                        blurRadius: 8,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: Color.fromARGB(255, 203, 126, 216),
                                      width: .8,
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30.0))),
                                height: 90,
                                width: 90,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),

                                  //radius: 49,
                                  //backgroundImage: NetworkImage(
                                  child: FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: list[index][2],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Text(
                                "  ",
                                style: TextStyle(fontSize: 6),
                              ),
                              Text(list[index][1],
                                  style: TextStyle(fontSize: 12))
                            ],
                          ),
                        ),
                      ),
                    ))
              ]),
            ),
          ),
        ),
      ]);
    }
  }
}
