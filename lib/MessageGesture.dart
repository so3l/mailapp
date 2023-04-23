import 'package:flutter/material.dart';
import 'messages.dart';

class MessageGesture extends StatelessWidget {
  MessageGesture({
    super.key,
    required this.emailaddress,
    required this.subject,
    required this.time,
    // required this.body,
    this.shadowcolor = 0xFFD0B3CA,
  });
  final String emailaddress;
  final String subject;
  final String time;
  // final String body;
  var shadowcolor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0, right: 4.0),
      child: SizedBox(
        height: 60,
        //color: Colors.red,
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                    color: Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(0),
                    boxShadow: [
                      BoxShadow(offset: Offset(2, 2), color: Color(shadowcolor))
                    ]),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: Icon(Icons.circle,
                          color: Color.fromARGB(255, 116, 90, 160), size: 15),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: RichText(
                          text: TextSpan(
                              text: emailaddress,
                              style: TextStyle(color: Colors.blue.shade800))),
                    ),
                    const SizedBox(width: 50),
                    Expanded(
                      child: Text(
                        subject,
                        style: const TextStyle(color: Colors.white70),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Icon(Icons.star_border,
                          color: Color.fromARGB(255, 144, 35, 71)),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MessagePage(
                              subject: subject,
                              emailaddress: emailaddress,
                              // body: body
                            )));
              },
            )
          ],
        ),
      ),
    );
  }
}
