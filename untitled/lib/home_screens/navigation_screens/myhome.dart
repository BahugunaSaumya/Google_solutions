import 'dart:typed_data';

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
  TextStyle myStyle = TextStyle(fontFamily: 'Gotham', fontSize: 13);
  TextStyle myStyleSmall =
  TextStyle(fontFamily: 'Gotham', fontSize: 12, color: Colors.grey[600]);
  final _minpadding = 5.0;

  Widget imageCarousel = Container(
    height: 170,
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
  Future<void> readExcelFile() async {
    // List list = new List();

    ByteData data = await rootBundle.load("Categories.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table].rows) {
        list.add(row);
      }
    }
  }







  @override
   Widget build(BuildContext context) {
    // var file = await rootBundle.load("assets/$fileName");
    // var bytes = File(file).readAsBytesSync();
    // var excel = Excel.decodeBytes(bytes);
    readExcelFile();
    {
      return Scaffold(

        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                imageCarousel,
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
                  height: 332,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: (context, index) =>
                        Card(
                          elevation: 2.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[

                              FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              fit: BoxFit.cover,
                              height: 90,
                              width: 150,
                              image:list[index][2]),
                              Text(
                                list[index][0].toString(),
                                style: myStyleSmall,
                              ),
                              Text(
                                list[index][1],
                                style: myStyle,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: _minpadding * 3),
                                child: Text("1000 ml", style: myStyleSmall),
                              ),
                              Padding(
                                padding: EdgeInsets.all(1.0),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.pink, // Background color
                                    onPrimary: Colors
                                        .amber, // Text Color (Foreground color)
                                  ),
                                  child: Text(
                                    "SUBSCRIBE @67",

                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Gotham',
                                        fontSize: 10.0),

                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 3),
                                child: Text(
                                  'MRP \u20B967',
                                  style:
                                  TextStyle(
                                      fontFamily: 'Gotham', fontSize: 10.0),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 3),
                                child: Container(
                                  height: 20,
                                  width: 200,
                                  color: Colors.grey[400],
                                  child: const Center(
                                      child: Text(
                                        'BUY ONCE',
                                        style: TextStyle(
                                            fontFamily: 'Gotham',
                                            fontSize: 10,
                                            color: Colors.white),
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                  ),

                ),

              ]

          ),
        ),
      );
    }
  }
}
