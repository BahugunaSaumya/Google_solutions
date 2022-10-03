import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmers_market/home_screens/navigation_screens/ProductDetails.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:farmers_market/product.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../ProductsPage.dart';
class myCategories extends StatelessWidget
{
  List<DocumentSnapshot> documents;
  myCategories(List<DocumentSnapshot> documents)
  { this.documents=documents;}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build





    return  SizedBox(


      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: documents.length,
        itemBuilder: (context, index) => Card(
          elevation: 0,
          color: Colors.transparent,
          shape: CircleBorder(),
          //  borderRadius: BorderRadius.all(Radius.circular(100))),
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              ProductsPage.Category=documents[index].id;
              product.li = documents;
              product.he = documents[index].id;
              Navigator.push(
                context,
                MaterialPageRoute(

                    builder: (context) => ProductsPage()),
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
              crossAxisAlignment:
              CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple
                              .withOpacity(0.4),
                          spreadRadius: 3,
                          blurRadius: 8,
                          offset: Offset(0,
                              3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 51,
                      backgroundColor: Color.fromARGB(
                          255, 203, 126, 216),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          documents[index].get("img"),
                        ),
                      ),
                    )),
                Text(
                  " ",
                  style: TextStyle(fontSize: 3),
                ),
                Text(documents[index].id,
                    style: TextStyle(fontSize: 14))
              ],
            ),
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }

}