import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'header.dart';
import 'MessageGesture.dart';

class PrimaryPage extends StatefulWidget {
  const PrimaryPage({super.key});

  @override
  State<PrimaryPage> createState() => _PrimaryPage();
}

class _PrimaryPage extends State<PrimaryPage> {
  List sub = [];
  List sen = [];
  List bod = [];
  @override
  // late String s = '';
  List subject(String response) {
    // Future<List> a = getEmailComp();
    // str = await a;
    // print(str);
    final decoded = json.decode(response);
    // setState(() {
    //   sub = decoded['Subject'];
    // });
    sub = decoded['Subject'];
    // print(Sub);
    return decoded['Subject'];
  }

  List emailaddress(String response) {
    // Future<List> a = getEmailComp();
    // str = await a;
    // print(str);
    final decoded = json.decode(response);
    // setState(() {
    //   sen = decoded['Sender'];
    // });
    sen = decoded['Sender'];
    // print(Sub);
    return decoded['Sender'];
  }

  // List body(String response) {
  //   // Future<List> a = getEmailComp();
  //   // str = await a;
  //   // print(str);
  //   final decoded = json.decode(response);
  //   // setState(() {
  //   //   sen = decoded['Sender'];
  //   // });
  //   bod = decoded['Body'];
  //   // print(Sub);
  //   return decoded['Body'];
  // }

  Future getSubject() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000'));
    // final decoded = json.decode(response.body) as Map<String, dynamic>;
    // return decoded['Subject'];
    // s = response.body;
    return subject(response.body);
  }

  Future getEmail() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000'));
    // final decoded = json.decode(response.body) as Map<String, dynamic>;
    // return decoded['Subject'];
    // s = response.body;
    return emailaddress(response.body);
  }

  // Future getBody() async {
  //   final response = await http.get(Uri.parse('http://127.0.0.1:5000'));
  //   // final decoded = json.decode(response.body) as Map<String, dynamic>;
  //   // return decoded['Subject'];
  //   // s = response.body;
  //   return body(response.body);
  // }

  int once = 1;
  @override
  Widget build(BuildContext context) {
    getSubject();
    getEmail();
    //getBody();
    // List subj = [];
    // subj = as(s);

    // print("\n");

    // List str = [];

    // as();
    // Future str = getEmailComp();
    // print(str);

    //print(str);
    // print("Length: $emailcomp");
    // var subject = emailcomp[0];
    // var emailaddress = emailcomp[1];
    int i = 0;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: const [
                Header(),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            SizedBox(
              height: 30,
              child: Stack(
                children: [
                  Row(
                    //mainAxisSize: MainAxisSize.min,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 60),
                        child: Text(
                          "Inbox",
                          style: TextStyle(
                              //backgroundColor: Colors.tealAccent,
                              color: Color.fromARGB(255, 160, 14, 63),
                              // decoration: TextDecoration.underline,
                              // decorationThickness: 2,
                              // decorationColor: Color(0xFF198B87),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0),
            // Container(
            //   height: 2,
            //   child: Container(
            //     color: Color.fromARGB(147, 100, 1, 50),
            //   ),
            // ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            for (var sub in sub)
              MessageGesture(
                emailaddress: sen[i++],
                subject: sub,
                // body: bod[i++],
                time: '23:15',
              ),
          ],
        ),
      ),
    );
  }
}
