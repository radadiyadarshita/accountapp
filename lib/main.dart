import 'package:accountapp/first.dart';
import 'package:accountapp/password.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: myapp(),
  ));
}

class myapp extends StatefulWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  @override
  void initState() {
    super.initState();
    splash();
  }
  splash() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.pushReplacement(this.context, MaterialPageRoute(
        builder: (context) {
          return pass();
        },
      ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body:SafeArea(child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150,
            color: Colors.deepPurple,
            alignment: Alignment.center,
            child: Image.asset("img/acc.jpg"),
            ),
        ],
      ),
    ));
  }
}

