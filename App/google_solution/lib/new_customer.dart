import 'package:flutter/material.dart';

import 'logincustomer.dart';
import 'loginfarmer.dart';

void main() {
  runApp(const new_customer());
}

class new_customer extends StatelessWidget {
  const new_customer({Key? key}) : super(key: key);

  static const String _title = 'New Customer';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatelessWidget(),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
             Column(

                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Name',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Email id',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Phone no',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Address',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Stack(

                      children: <Widget>[
                        Positioned.fill(

                          child:Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Color(0xFF0D47A1),
                                  Color(0xFF1976D2),
                                  Color(0xFF42A5F5),
                                ],
                              ),
                            ),
                          ),
                        ),

                        TextButton(

                          style: TextButton.styleFrom(

                            padding: const EdgeInsets.all(15.0),
                            primary: Colors.white,
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () {},
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ),
    ]
             )

        ]);
  }

}

