import 'package:farmers_market/home_screens/drawer_items/my_orders.dart';

import '/home_screens/navigation_screens/chat.dart';
import '/home_screens/navigation_screens/myWallet.dart';
import '/home_screens/navigation_screens/myhome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'navigation_screens/ProductDetails.dart';
import 'navigation_screens/subs_screen.dart';

void main() {

  runApp(
      MaterialApp(
          home:ProductsPage()));
}
class ProductsPage extends StatefulWidget {
  static String Category ;
  @override
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {
  ScbsPage _subsPage;
  ProductDetails _myHomePage;
  MyWallet _myWallet;
  Chats _chats;

  List<Widget> pages;
  Widget currentPage;

  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
      fontFamily: 'Gotham', fontSize: 13, fontWeight: FontWeight.normal);

  @override
  void initState() {
    _subsPage = ScbsPage();
    _myHomePage = ProductDetails();
    _myWallet = MyWallet();
    _chats = Chats();

    pages = [_myHomePage, _subsPage, _myWallet, _chats];
    currentPage = _myHomePage;
    ProductDetails.Category=ProductsPage.Category;
    super.initState();
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
    ),
    Text(
      'Index 1: Subscription',
    ),
    Text(
      'Index 2: My wallet',
    ),
    Text(
      'Index 2: Chat',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            label: "Subscription",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'My wallet',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.pink,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
            currentPage = pages[index];
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(),
              );
            },
          ),
          IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Fluttertoast.showToast(
                    msg: "Account Clicked",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 14.0);
              }),
        ],
        title: Text(
          'Daily',
          style: TextStyle(fontFamily: 'Gotham'),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                'Dnyaneshwar Dalvi',
                style: TextStyle(fontFamily: 'Gotham'),
              ),
              accountEmail: Text(
                'dnyane.dalvi@gmail.com',
                style: TextStyle(fontFamily: 'Gotham'),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  'D',
                  style: TextStyle(fontFamily: 'Gotham', fontSize: 25.0),
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Home',
                style: TextStyle(fontFamily: 'Gotham', fontSize: 15.0),
              ),
              leading: Icon(Icons.home),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              title: Text(
                'My Account',
                style: TextStyle(fontFamily: 'Gotham', fontSize: 15.0),
              ),
              leading: Icon(Icons.account_circle),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              title: Text(
                'Notification',
                style: TextStyle(fontFamily: 'Gotham', fontSize: 15.0),
              ),
              leading: Icon(Icons.notifications_active),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
                title: Text(
                  'My Order',
                  style: TextStyle(fontFamily: 'Gotham', fontSize: 15.0),
                ),
                leading: Icon(Icons.beenhere),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MyOrders  ()));
                  // Navigator.of(context).pushReplacementNamed('/myOrders');
                }),
            ListTile(
              title: Text(
                'Your Story',
                style: TextStyle(fontFamily: 'Gotham', fontSize: 15.0),
              ),
              leading: Icon(Icons.content_paste),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              title: Text(
                'Shop By Category',
                style: TextStyle(fontFamily: 'Gotham', fontSize: 15.0),
              ),
              leading: Icon(Icons.grid_on),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              title: Text(
                'Rate our App',
                style: TextStyle(fontFamily: 'Gotham', fontSize: 15.0),
              ),
              leading: Icon(Icons.star),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              title: Text(
                'Need Help?',
                style: TextStyle(fontFamily: 'Gotham', fontSize: 15.0),
              ),
              leading: Icon(Icons.help_outline),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              title: Text(
                'Share',
                style: TextStyle(fontFamily: 'Gotham', fontSize: 15.0),
              ),
              leading: Icon(Icons.share),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              title: Text(
                'Logout',
                style: TextStyle(fontFamily: 'Gotham', fontSize: 15.0),
              ),
              leading: Icon(Icons.input),
              onTap: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final items = [
    'Milk',
    'Fruits',
    'Vegitable',
    'Bakery Products',
    'Beverages',
    'Beauty & Hygiene',
    'Pet Care',
    'Breakfast & Snacks',
    'Pooja Needs',
    'Food Grains Oils & Masalas',
    'Baby Care'
  ];
  final recentItems = ['Milk', 'Fruits', 'Vegitable'];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(color: Colors.white // This is optional
    );
    ;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggetionList = query.isEmpty
        ? recentItems
        : items.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.settings_input_svideo),
        title: RichText(
          text: TextSpan(
              text: suggetionList[index].substring(0, query.length),
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggetionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
      ),
      itemCount: suggetionList.length,
    );
  }
}
