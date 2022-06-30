import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';

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

  @override
  Widget build(BuildContext context) {
    var file = "untitled/Categories.xlsx";
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      print(table); //sheet Name
      print(excel.tables[table].maxCols);
      print(excel.tables[table].maxRows);
      for (var row in excel.tables[table].rows) {
        print("$row");
      }
    }
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
                'ALL MILK',
                style: myStyle,
              ),
            ),
            SizedBox(
              height: 332,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context,index) => Card(
                    elevation: 2.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image(
                          width: 180.0,
                          image: AssetImage('images/milk1.jpg'),
                        ),
                        Text(
                          "AMUL",
                          style: myStyleSmall,
                        ),
                        Text(
                          "Amul Taaza",
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
                              onPrimary: Colors.amber, // Text Color (Foreground color)
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
                                TextStyle(fontFamily: 'Gotham', fontSize: 10.0),
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
