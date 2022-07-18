import 'package:farmers_market/landing.dart';
import 'package:farmers_market/logincustomer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import '/home_screens/main_view.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'home_screens/navigation_screens/myhome.dart';
import 'home_screens/drawer_items/my_orders.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.pink,
        canvasColor: Colors.white,
        accentColor: Colors.red),
    routes: <String, WidgetBuilder>{
      '/a': (BuildContext context) => MainView(),
      '/b': (BuildContext context) => MyHome(),
      '/homePage': (BuildContext context) => landing(),
      '/myOrders': (BuildContext context) => MyOrders(),
    },
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadScreen();
  }

  Future<Timer> loadScreen() async {
    return Timer(Duration(seconds: 2), _loadUI);
  }

  void _loadUI() async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => landing()));
    //  Navigator.of(context).pushReplacementNamed('/homePage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showSplashScreen(),
    );
  }

  Widget _showSplashScreen() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('./images/splash.jpg'), fit: BoxFit.cover)),
    );
  }
}
