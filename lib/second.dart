import 'dart:convert';
import 'package:accountapp/App.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:http/http.dart' as http;

class second extends StatefulWidget {
  String? id;
  String? name;
  second(this.name,this.id);


  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {
TextEditingController t1=TextEditingController();
TextEditingController t2=TextEditingController();
TextEditingController t3=TextEditingController();
String _horizontalGroupValue = "Credit(+)";
List<String> _status = ["Credit(+)", "Debit(-)"];
List<App> applist = [];
Future<List<App>> getdata() async {
  var url = Uri.parse('https://dashuflutter.000webhostapp.com/account/acc.php');
  var response = await http.get(url);
  print(response.body);
  print(response.statusCode);
  List<dynamic> m=jsonDecode(response.body);
  applist.clear();
  m.forEach((element) {
    applist.add(App.fromJson(element));
  });
  print(applist);
  return applist;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.name}"),
      actions: [
        IconButton(onPressed: () {
          showDialog(context: context, builder:(context){
            return StatefulBuilder(builder: (context, setState1) {
            return AlertDialog(
                title: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.deepPurple,
                      child: Text("Add transaction"),
                    ),
                    Container(
                        child:  Text("Transaction date",textAlign: TextAlign.end,)),
                    Container(child:TextField(controller: t1,)),
                    Container(alignment: Alignment.topLeft,child:  Text("Transaction type"),),
                    RadioGroup<String>.builder(
                      direction: Axis.vertical,
                      groupValue: _horizontalGroupValue,
                      horizontalAlignment: MainAxisAlignment.spaceAround,
                      onChanged: (value) => setState1(() {
                        _horizontalGroupValue = value!;
                      }),
                      items: _status,
                      textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.blue
                      ),
                      itemBuilder: (item) => RadioButtonBuilder(
                        item,

                      ),
                    ),
                    Container(child:TextField(controller: t2,decoration: InputDecoration(hintText: "Amount"),)),
                    Container(child:TextField(controller: t3,decoration: InputDecoration(hintText: "Particular"))),
                    Row(
                      children:[
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 40,
                            width: 90,
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(5),
                            child: Text("CANCEL",
                                style: TextStyle(color: Colors.purple)),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.purple),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            String type=_horizontalGroupValue;
                            String date=t1.text;
                            String amount=t2.text;
                            String reason=t3.text;
                            int acc_id=int.parse(widget.id!);
                            var url = Uri.parse('https://dashuflutter.000webhostapp.com/account/acc1.php?date=$date&type=$type&amount=$amount&reason=$reason&acc_id=$acc_id');
                            var response = await http.get(url);
                            print(response.body);
                            print(response.statusCode);
                            if(response.body=="data insert") {
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) {
                                  return second(widget.id,widget.name);
                                },));
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 90,
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(5),
                            child:
                            Text("ADD", style: TextStyle(color: Colors.white)),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              border: Border.all(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },);
          });
        }, icon: Icon(Icons.upload_file_outlined)),
        IconButton(onPressed: () {

        }, icon: Icon(Icons.search)),
        PopupMenuButton(itemBuilder: (context) => [
          PopupMenuItem(child: Text("Save as PDF")),
          PopupMenuItem(child: Text("Save as Excel")),
          PopupMenuItem(child: Text("Share the app")),
          PopupMenuItem(child: Text("Rate the app")),
          PopupMenuItem(child: Text("More apps")),
        ],)
      ],
      ),
      body:RepaintBoundary(child:Column(
        children: [
          Container(
            height: 40,
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Date"),
                Text("Particular"),
                Text("credit(Rs)"),
                Text("Debit(Rs)"),
              ],
            ),
          ),
          // FutureBuilder(future: getdata(),builder: (context, snapshot) {
          //   if(snapshot.connectionState==ConnectionState.done){
          //       return ListView.builder(itemBuilder: (context, index) {
          //        return Container(
          //
          //        );
          //       },shrinkWrap: true,);
          //   }
          //   else{
          //     return Center(child: CircularProgressIndicator(),);
          //   }
          // },),
        ],
      ),
    ));
  }
}
