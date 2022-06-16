import 'package:flutter/material.dart';
import 'package:google_solution/loginfarmer.dart';
import 'logincustomer.dart';
import 'loginfarmer.dart';

class MyElevatedButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final Widget child;

  const MyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.height = 44.0,
    this.gradient = const LinearGradient(colors: [Colors.cyan, Colors.indigo]),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(0);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: child,
      ),
    );
  }
}

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
            height: 120,
            width: 170,
            child: Align(
              alignment: Alignment.center,
              child: MyElevatedButton(
                height: 180,
                width: 130,
                borderRadius: BorderRadius.circular(20),
                // style: MyElevatedButton.styleFrom(
                //   primary: Color(0xFF42F581), // background
                //   onPrimary: Color.fromARGB(255, 0, 0, 0), // background

                //   padding: const EdgeInsets.fromLTRB(28, 50, 28, 50),
                // ),
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
          Container(
            height: 120,
            width: 180,
            child: Align(
              alignment: Alignment.center,
              child: MyElevatedButton(
                height: 180,
                width: 130,
                borderRadius: BorderRadius.circular(20),
                // style: ElevatedButton.styleFrom(
                //   primary: Color.fromARGB(0, 0, 0, 0),
                //   onPrimary: Color.fromARGB(255, 255, 255, 255),
                //   padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
                // ),
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
