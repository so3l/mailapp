import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: const BoxDecoration(
          color: Color(0xFF1F1F1F),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: Row(
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
            child: Text(
              "Hey_there",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Color(0xFF7167C4), fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            "!",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Color(0xFF198B87), fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
