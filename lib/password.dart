import 'package:accountapp/first.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

class pass extends StatefulWidget {
  const pass({Key? key}) : super(key: key);

  @override
  State<pass> createState() => _passState();
}

class _passState extends State<pass> {
  bool confirm=true;
  String str='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ScreenLock(
        digits: 4,
        secretsConfig: SecretsConfig(
          spacing: 30,
          secretConfig: SecretConfig(
            borderColor: Colors.deepPurpleAccent,
            enabledColor: Colors.blueGrey,
            disabledColor: Colors.grey,
            build: (context, {required config, required enabled}) {
              return SizedBox(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: enabled?config.enabledColor:config.disabledColor,
                    border: Border.all(
                      width: config.borderSize,
                    )
                  ),
                  padding: EdgeInsets.all(10),
                  width: config.width,
                  height: config.height,
                ),
                width: config.width,
                height: config.height,
              );
            },
          ),
        ),
        didConfirmed: (matchedText) {
          print(matchedText);
          setState((){
            confirm=false;
            str=matchedText;
          });
        }, didUnlocked: () {
         Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) {
           return page1();
         },));
      },
        correctString: str,
        confirmation: confirm,
        confirmTitle: Text("Repeat your password"),
        title: confirm?Text("set your password"):Text("unlock password"),
      ),

      );
  }
}
