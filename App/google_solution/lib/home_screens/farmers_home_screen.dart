import 'package:farmers_market/AddNewDocument.dart';
import 'package:farmers_market/NewProduct.dart';
import 'package:farmers_market/landing.dart';
import 'package:flutter/material.dart';
import 'widgets/fab.dart';

class farmers_home_screen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<farmers_home_screen> {
  int _currentBottomTab = 0;

  List<Widget> pages = [new_product(), AddNewDocument()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Icon(
          Icons.animation,
          color: Colors.grey.shade800,
        ),
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
      floatingActionButton: InstagramFab(
        icon: Icons.add,
        onTap: () {
          setState(() {
            _currentBottomTab = 1;
          });
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
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
      height: 56,
      child: BottomAppBar(
        elevation: 8,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.home,
                  color: getColor(0),
                ),
                onPressed: () {
                  refreshUI(0);
                }),
            IconButton(
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
                }),
            IconButton(
                icon: Icon(
                  Icons.person_outline,
                  color: getColor(3),
                ),
                onPressed: () {
                  refreshUI(3);
                }),
          ],
        ),
      ),
    );
  }
}
