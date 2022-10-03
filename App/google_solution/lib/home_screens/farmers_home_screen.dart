import 'package:farmers_market/AddNewDocument.dart';
import 'package:farmers_market/NewProduct.dart';
import 'package:farmers_market/home_screens/navigation_screens/famerprofile.dart';
import 'package:farmers_market/landing.dart';
import 'package:flutter/material.dart';
import 'widgets/fab.dart';

class farmers_home_screen extends StatefulWidget {
  static int _currentBottomTab;
  static int fl;
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<farmers_home_screen> {
  static int _currentBottomTab = farmers_home_screen._currentBottomTab;

  List<Widget> pages = [
    new new_product(),
    new AddNewDocument(),
    new farmerprofile()
  ];

  @override
  Widget build(BuildContext context) {
    if (_currentBottomTab == null) {
      _currentBottomTab = 0;
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Icon(
          Icons.animation,
          color: Colors.grey.shade800,
        ),
        backgroundColor: Colors.pink,
        title: Text(
          "Farmers",
          style: TextStyle(fontSize: 22),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: new IconButton(
              icon: new Icon(Icons.logout),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => landing()),
                );
              },
            ),
          ),
        ],
      ),
      body: pages[_currentBottomTab],
      floatingActionButton: check(_currentBottomTab),
      /* InstagramFab(
        icon: Icons.add,
        onTap: () {
          setState(() {
            _currentBottomTab = 0;
          });
        },
      ),*/
      bottomNavigationBar: _buildBottomNavigationBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget check(int cu) {
    if (cu == 0) {
      return InstagramFab(
        icon: Icons.add,
        onTap: () {
          AddNewDocument.user = new_product.user_id;
          AddNewDocument.cate = new_product.se;

          if (new_product.se == "") {
            showAlertDialog(context);
          } else {
            setState(() {
              _currentBottomTab = 1;
            });
          }
        },
      );
    } else {
      return null;
    }
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    Color getColor(int index) {
      return _currentBottomTab == index
          ? Theme.of(context).accentColor
          : Colors.grey.shade700;
    }

    void refreshUI(int currentTab) {
      setState(() {
        _currentBottomTab = currentTab;
      });
    }

    return Container(
        height: 45,
        child: ClipRRect(
          borderRadius: BorderRadius.only(

            topLeft: Radius.circular(90),
            topRight: Radius.circular(
              90,
            ),
          ),
          child: BottomAppBar(
            color: Colors.amber,
            elevation: 8,
            shape: CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.home,
                      color: getColor(0),
                    ),
                    onPressed: () {
                      new_product.se = "";
                      refreshUI(0);
                    }),
                /*     IconButton(
                    icon: Icon(Icons.search),
                    color: getColor(1),
                    onPressed: () {
                      refreshUI(1);
                    }),
                SizedBox(
                  width: 12,
                ),
                IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: getColor(2),
                    ),
                    onPressed: () {
                      refreshUI(2);
                    }),*/
                IconButton(
                    icon: Icon(
                      Icons.person_outline,
                      color: getColor(2),
                    ),
                    onPressed: () {
                      refreshUI(2);
                    }),
              ],
            ),
          ),
        ));
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