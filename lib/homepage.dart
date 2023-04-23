import 'package:flutter/material.dart';
import 'Primary.dart';
import 'spam.dart';
import 'important.dart';
import 'starred.dart';
//import 'messages.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  int index = 0;
  bool hover = false;
  Widget build(BuildContext context) {
    Widget page;
    switch (index) {
      case 0:
        page = const PrimaryPage();
        break;
      case 1:
        page = const ImportantPage();
        break;
      case 2:
        page = const StarredPage();
        break;
      case 3:
        page = const SpamPage();
        break;
      default:
        throw UnimplementedError('no widget for $index');
    }
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Color(0xFF4E0028),
          //   // title: Text(
          //   //   "SB",
          //   //   style: TextStyle(
          //   //       fontWeight: FontWeight.bold, color: Color(0xFF002411)),
          //   // ),
          //   leading: InkWell(
          //     child: Icon(Icons.radio_button_off_sharp),
          //     onTap: () {},
          //   ),
          // ),
          body: Row(
        children: [
          SafeArea(
              child: InkWell(
            onHover: (value) {
              setState(() {
                hover = value;
              });
            },
            child: NavigationRail(
              indicatorColor: const Color(0xFF7167C4),
              backgroundColor: const Color(0xFF1F1F1F),
              selectedIconTheme:
                  const IconThemeData(color: Color.fromARGB(255, 28, 127, 181)),
              unselectedIconTheme: const IconThemeData(
                  color: Color.fromARGB(208, 5, 71, 106), opacity: 70),
              extended: false,
              destinations: const [
                NavigationRailDestination(
                    icon: Icon(Icons.inbox), label: Text("Inbox")),
                NavigationRailDestination(
                    icon: Icon(Icons.label_important),
                    label: Text("Important")),
                NavigationRailDestination(
                    icon: Icon(Icons.favorite_outlined),
                    label: Text("Favourites")),
                NavigationRailDestination(
                    icon: Icon(Icons.report), label: Text("Spam")),
              ],
              selectedIndex: index,
              onDestinationSelected: (value) {
                setState(() {
                  index = value;
                });
              },
            ),
          )),
          Expanded(
              child: Container(
            child: page,
          ))
        ],
      ));
    });
  }
}
