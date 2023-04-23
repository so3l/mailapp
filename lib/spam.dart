import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'header.dart';
import 'MessageGesture.dart';

class SpamPage extends StatefulWidget {
  const SpamPage({super.key});

  @override
  State<SpamPage> createState() => _SpamPage();
}

class _SpamPage extends State<SpamPage> {
  List sub = [];
  List sen = [];
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

  Future getSubject() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/spam'));
    // final decoded = json.decode(response.body) as Map<String, dynamic>;
    // return decoded['Subject'];
    // s = response.body;
    return subject(response.body);
  }

  Future getEmail() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/spam'));
    // final decoded = json.decode(response.body) as Map<String, dynamic>;
    // return decoded['Subject'];
    // s = response.body;
    return emailaddress(response.body);
  }

  int once = 1;
  @override
  Widget build(BuildContext context) {
    getSubject();
    getEmail();
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
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 60),
                        child: Text(
                          "Spam",
                          style: TextStyle(
                              //backgroundColor: Colors.tealAccent,
                              color: Colors.red.shade700,
                              // decoration: TextDecoration.underline,
                              // decorationThickness: 1.5,
                              // decorationColor: Colors.brown.shade600,
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
                time: '23:15',
                shadowcolor: 0xFF47313C,
              ),
          ],
        ),
      ),
    );
  }
}
