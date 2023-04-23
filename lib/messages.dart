import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({
    super.key,
    required this.subject,
    required this.emailaddress,
    // required this.body
  });
  final String subject;
  final String emailaddress;
  // final String body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Color(0xFF1F1F1F),
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Tooltip(
                    message: "Change Label",
                    waitDuration: const Duration(milliseconds: 500),
                    showDuration: const Duration(milliseconds: 100),
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.label))),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Tooltip(
                    message: "Spam",
                    waitDuration: const Duration(milliseconds: 500),
                    showDuration: const Duration(milliseconds: 100),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.report_gmailerrorred))),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Tooltip(
                  message: "Delete",
                  waitDuration: const Duration(milliseconds: 500),
                  showDuration: const Duration(milliseconds: 100),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete_outline_outlined)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Tooltip(
                    message: "More options",
                    waitDuration: const Duration(milliseconds: 500),
                    showDuration: const Duration(milliseconds: 100),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_horiz_sharp))),
              ),
            ],
          )
        ],
      ),
      backgroundColor: Colors.grey.shade800,
      body: Column(
        children: [
          RichText(text: const TextSpan(text: "fd")),
          Text(
            subject,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(height: 20),
          Text(
            emailaddress,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.blue.shade200),
          ),
          // const Text("Time")
        ],
      ),
    );
  }
}
