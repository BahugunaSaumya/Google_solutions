import 'package:farmers_market/home_screens/main_view.dart';
import 'package:flutter/material.dart';
import 'new_farmers.dart';
import 'landing.dart';

void main() {
  runApp(const loginFarmer());
}

class loginFarmer extends StatelessWidget {
  const loginFarmer({Key key}) : super(key: key);

  static const String _title = 'Blah Blah Blah';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: new Text(
          "New Customer",
          style: new TextStyle(color: Colors.white),
        ),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => landing()),
              );
            },
          ),),
        body: const MyStatelessWidget(),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 30),
          Container(
              width: 180.0,
              height: 30.0,
              child: const TextField(
                obscureText: false,
                maxLines: 1,
                style:
                    TextStyle(fontSize: 15.0, height: 1.0, color: Colors.black),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(7.0, 9.0, 7.0, 9.0),
                  labelText: 'Username',
                ),
              )),
          const SizedBox(height: 20),
          Container(
              width: 180.0,
              height: 30.0,
              child: const TextField(
                maxLines: 1,
                obscureText: true,
                style:
                    TextStyle(fontSize: 15.0, height: 1.0, color: Colors.black),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(7.0, 9.0, 7.0, 9.0),
                  labelText: 'Password',
                ),
              )),
          const SizedBox(height: 100),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color.fromARGB(255, 0, 0, 0),
                          Color.fromARGB(255, 0, 0, 0),
                          Color.fromARGB(255, 0, 0, 0),
                        ],
                      ),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MainView()));
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              primary: Colors.blue,
              textStyle: const TextStyle(fontSize: 16),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => new_farmers()),
              );
            },
            child: const Text('Create a new account'),
          ),
        ],
      ),
    ));
  }
}
