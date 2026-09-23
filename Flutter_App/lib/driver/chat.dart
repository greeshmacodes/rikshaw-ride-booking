import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rickshaw_ride/driver/drhome.dart';
import 'package:rickshaw_ride/user/urhome.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const MyChatApp());
}

class MyChatApp extends StatelessWidget {
  const MyChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyChatPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyChatPage extends StatefulWidget {
  const MyChatPage({super.key, required this.title});



  final String title;

  @override
  State<MyChatPage> createState() => _MyChatPageState();
}

class ChatMessage {
  String messageContent;
  String messageType;

  ChatMessage({required this.messageContent, required this.messageType});
}

class _MyChatPageState extends State<MyChatPage> {
  int _counter = 0;
  String name = "";
  bool _isD = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _isD = true;
    super.dispose();
  }
  _MyChatPageState() {
      Timer.periodic(Duration(seconds: 2), (_) {
        if(_isD==false){
        view_message();
    }
      });
  }

  List<ChatMessage> messages = [];

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  TextEditingController te_message = TextEditingController();

  List<String> from_id_ = <String>[];
  List<String> to_id_ = <String>[];
  List<String> message_ = <String>[];
  List<String> date_ = <String>[];
  List<String> type = <String>[];

  Future<void> view_message() async {
    final pref = await SharedPreferences.getInstance();
    name = "Hello" ;pref.getString("name").toString();


    List<String> fromId = <String>[];
    List<String> toId = <String>[];
    List<String> message = <String>[];
    List<String> date = <String>[];
    List<String> type = <String>[];

    try {
      final pref = await SharedPreferences.getInstance();
      String urls = pref.getString('ip').toString();
      String url = '$urls/driver_viewchat';

      var data = await http.post(Uri.parse(url), body: {
        'from_id': pref.getString("did").toString(),
        'to_id': pref.getString("userid").toString()
      });
      var jsondata = json.decode(data.body);
      String status = jsondata['status'];
      print(status);

      var arr = jsondata["data"];
      print(arr);


      messages.clear();


      for (int i = 0; i < arr.length; i++) {
        fromId.add(arr[i]['from'].toString());
        toId.add(arr[i]['to'].toString());
        message.add(arr[i]['msg']);
        date.add(arr[i]['date'].toString());
        type.add(arr[i]['type'].toString());

        if ('driver' == arr[i]['type'].toString()) {
          messages.add(ChatMessage(
              messageContent: arr[i]['msg'], messageType: "sender"));
        } else {
          messages.add(ChatMessage(
              messageContent: arr[i]['msg'], messageType: "receiver"));
        }
      }


      setState(() {
        from_id_ = fromId;
        to_id_ = toId;
        message_ = message;
        date_ = date;
        type = type;

        messages = messages;
      });

      print(status);
    } catch (e) {
      print("Error ------------------- $e");
    }
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async{
        Navigator.push(context, MaterialPageRoute(builder: (context) => urhome(),));
        return true;
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 228, 213, 231),

        appBar: AppBar(
            title: Text(
              name,
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>drhome()));
                // print("Hello");

              },
            )),
        body: Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10, bottom: 50),
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: (messages[index].messageType == "receiver"
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (messages[index].messageType == "receiver"
                            ? Colors.grey.shade200
                            : Colors.blue[200]),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Text(
                        messages[index].messageContent,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        controller: te_message,
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () async {
                        String fid = "";
                        String toid = "";
                        String message = te_message.text.toString();

                        /////
                        try {
                          final pref = await SharedPreferences.getInstance();
                          String ip = pref.getString("ip").toString();

                          String url = "$ip/driver_sendchat";

                          var data = await http.post(Uri.parse(url), body: {
                            'message': message,
                            'from_id': pref.getString("did").toString(),
                            'to_id': pref.getString("userid").toString()
                          });
                          var jsondata = json.decode(data.body);
                          String status = jsondata['status'];

                          te_message.text = "";

                          var arr = jsondata["data"];

                          setState(() {});

                          print("");
                        } catch (e) {
                          print("Error ------------------- $e");
                          //there is error during converting file image to base64 encoding.
                        }
                        ////

                        // print("Hiiiiii");
                        //
                        // setState(() {
                        //
                        //   List<ChatMessage> messages1= messages;
                        //   messages1.add(ChatMessage(messageContent: "Hello, Fadhil", messageType: "receiver"));
                        //   setState(() {
                        //
                        //     messages=messages1;
                        //   });
                        //
                        // });
                      },
                      backgroundColor: Colors.cyan,
                      elevation: 0,
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
