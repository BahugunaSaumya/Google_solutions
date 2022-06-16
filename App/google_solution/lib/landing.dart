import 'package:flutter/material.dart';
import 'package:google_solution/loginfarmer.dart';
import 'logincustomer.dart';
import 'loginfarmer.dart';

void main() {
  runApp(const landing());
}

class landing extends StatelessWidget {
  const landing({Key? key}) : super(key: key);

  static const String _title = 'Blah Blah Blah';

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
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 30),
          Container(
            height: 200,
            width: 130,
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF42F581), // background
                  onPrimary: Color.fromARGB(255, 0, 0, 0), // background

                  padding: const EdgeInsets.fromLTRB(28, 50, 28, 50),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => loginFarmer()),
                  );
                },
                child: const Text(
                  'Farmer',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(12),
          //   child: Stack(
          //     children: <Widget>[
          //       Positioned.fill(
          //         child: Container(
          //           decoration: const BoxDecoration(
          //             gradient: LinearGradient(
          //               colors: <Color>[
          //                 Color.fromARGB(255, 0, 0, 0),
          //                 Color.fromARGB(255, 0, 0, 0),
          //                 Color.fromARGB(255, 0, 0, 0),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //       TextButton(
          //         style: TextButton.styleFrom(
          //           padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          //           primary: Colors.white,
          //           textStyle: const TextStyle(fontSize: 16),
          //         ),
          //         onPressed: () {},
          //         child: const Text('Login'),
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            height: 180,
            width: 120,
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF42F581), // background
                  onPrimary: Color.fromARGB(255, 0, 0, 0),
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => loginCustomer()),
                  );
                },
                child: const Text(
                  'Customer',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
