import 'dart:convert';
import 'package:accountapp/App.dart';
import 'package:accountapp/second.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class page1 extends StatefulWidget {
  const page1({Key? key}) : super(key: key);

  @override
  State<page1> createState() => _page1State();
}

class _page1State extends State<page1> {
  TextEditingController t1 = TextEditingController();
  TextEditingController names = TextEditingController();
  List<App> applist = [];

  Future<List<App>> getdata() async {
    var url = Uri.parse('https://dashuflutter.000webhostapp.com/account/view.php');
    var response = await http.get(url);
    print(response.body);
    print(response.statusCode);
    List<dynamic> m=jsonDecode(response.body);
    applist.clear();
    m.forEach((element) {
      applist.add(App.fromJson(element));
    });
    return applist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Dashboard", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.search, color: Colors.white)),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(child: Text("Save as PDF")),
              PopupMenuItem(child: Text("Save as Save as Excel")),
            ],
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              child: Image.asset("img/acc.jpg"),
            ),
            Container(
              child: Text("Account Manager"),
            ),
            ListTile(onTap: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) {
               return page1();
             },)) ;
            },leading: Icon(Icons.home),title: Text("Home"),),
            ListTile(onTap: () {
            },leading: Icon(Icons.backup),title: Text("Backup"),),
            ListTile(onTap: () {
            },leading: Icon(Icons.restore),title: Text("Restore"),),
            ListTile(onTap: () {
            },leading: Icon(Icons.settings),title: Text("Change Currency"),),
            ListTile(onTap: () {
            },leading: Icon(Icons.settings),title: Text("Change password"),),
            ListTile(onTap: () {
            },leading: Icon(Icons.settings_cell_sharp),title: Text("Change security question"),),
            ListTile(onTap: () {
            },leading: Icon(Icons.settings),title: Text("Settings"),),
            ListTile(onTap: () {
            },leading: Icon(Icons.share),title: Text("Share the app"),),
            ListTile(onTap: () {
            },leading: Icon(Icons.star),title: Text("Rate the app"),),
            ListTile(onTap: () {
            },leading: Icon(Icons.privacy_tip_outlined),title: Text("Privacy Policy"),),
            ListTile(onTap: () {
            },leading: Icon(Icons.apps),title: Text("More apps"),),
            ListTile(onTap: () {
            },leading: Icon(Icons.ads_click),title: Text("Ads free"),),

          ],
        ),
      ),
      body: FutureBuilder(future: getdata(),builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.done)
        {
          if(snapshot.hasData)
          {
            List<App> l = snapshot.data as List<App>;

            return ListView.builder(itemCount: l.length,itemBuilder: (context, index) {
              return Container(
                height: 150,
                width: double.infinity,
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Expanded(flex:1,child: Row(
                      children: [
                       InkWell(
                         onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) {
                             return second(l[index].name,l[index].id);
                           },));
                         },
                           child: Container(
                             child: Text("${l[index].name}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                           )
                       ),
                        Expanded(flex: 1,child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle
                          ),
                          child: IconButton(onPressed: () {
                            showDialog(context: context,builder: (context) {
                                  names.text=l[index].name!;
                                  return AlertDialog(
                                    title: Column(
                                      children: [
                                        Container(
                                            color: Colors.deepPurple,
                                            child: Text(
                                              "Update account",
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )
                                        ),
                                      ],
                                    ),
                                    content: TextField(
                                      controller: names,
                                      decoration: InputDecoration(
                                        hintText: "Account name",
                                      ),
                                    ),
                                    actions: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 110,
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.purple),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Text("CANCEL",
                                              style: TextStyle(color: Colors.purple)),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          String name=t1.text;
                                          var url = Uri.parse('https://dashuflutter.000webhostapp.com/account/update.php?id=${l[index].id}&name=${l[index].name}');
                                          var response = await http.post(url);
                                          if(response.body=="data update") {
                                            Navigator.pushReplacement(context, MaterialPageRoute(
                                              builder: (context) {
                                                return page1();
                                              },));
                                          }
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 110,
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: Colors.deepPurple,
                                            border: Border.all(color: Colors.deepPurple),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child:
                                          Text("update", style: TextStyle(color: Colors.white)),
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          }, icon: Icon(Icons.edit_calendar_sharp,color: Colors.deepPurpleAccent,)),
                        )),
                        Expanded(flex: 1,child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle
                          ),
                          child: IconButton(onPressed: () async {
                            var url = Uri.parse('https://dashuflutter.000webhostapp.com/account/deleteacc.php?id=${l[index].id}');
                            var response = await http.get(url);
                            print(response.body);
                            if(response.body=="data delete"){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                return page1();
                              },));
                            }

                          }, icon: Icon(Icons.delete,color: Colors.purple,)),
                        )),
                      ],
                    )),
                    Expanded(flex: 2,child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white24,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Center(child: Text("Credit(!)")),
                                Center(child: Text("0")),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Center(child: Text("Debit(!)")),
                                Center(child: Text("0")),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.purple,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Center(child: Text("Balance")),
                                Center(child: Text("0")),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white60
                ),
              );
            },);
          }
          else
          {
            return Center(child: CircularProgressIndicator());
          }
        }
        else
        {
          return Center(child: CircularProgressIndicator());
        }
      },),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          showDialog(
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Column(
                    children: [
                      Container(
                          color: Colors.deepPurple,
                          child: Text(
                            "Add new account",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                      ),
                    ],
                  ),
                  content: TextField(
                    controller: t1,
                    decoration: InputDecoration(
                      hintText: "Account name",
                    ),
                  ),
                  actions: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 110,
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.purple),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text("CANCEL",
                            style: TextStyle(color: Colors.purple)),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        String name=t1.text;
                        var url = Uri.parse('https://dashuflutter.000webhostapp.com/account/acco.php?name=$name');
                        var response = await http.get(url);
                        print(response.body);
                        if(response.body=="data insert") {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return page1();
                            },));
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 110,
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          border: Border.all(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child:
                        Text("SAVE", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                );
              },
              context: context);
        },
        child: Icon(
          Icons.create_new_folder_sharp,
          color: Colors.white,
        ),
      ),
    );
  }
}


