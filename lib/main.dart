import 'package:flutter/material.dart';
import 'homepage.dart';
//import 'messages.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

void main() {
  runApp(const MyApp());
}

const FlexSchemeData customFlexScheme = FlexSchemeData(
  name: 'Toledo purple',
  description: 'Purple theme created from custom defined colors.',
  light: FlexSchemeColor(
    primary: Color(0xFF4E0028),
    primaryVariant: Color(0xFF320019),
    secondary: Color(0xFF003419),
    secondaryVariant: Color(0xFF002411),
  ),
  dark: FlexSchemeColor(
    primary: Color(0xFF9E7389),
    primaryVariant: Color(0xFF775C69),
    secondary: Color(0xFF738F81),
    secondaryVariant: Color(0xFF5C7267),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // The color scheme for the dark theme, made toTheme
      darkTheme: FlexColorScheme.dark(
        colors: customFlexScheme.dark,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
      ).toTheme,
      home: MyHomePage(),
    );
  }
}

/*color: 0xFF1F1F1F
0xFF656EA4
0xFFD0B3CA
0xFF157F1F*/

/*alternative: 0xFF47313C
0xFF7167C4
0xFFD0B2D1
0xFF198B87*/