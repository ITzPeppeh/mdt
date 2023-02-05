import 'package:flutter/material.dart';
import 'package:mdt/pages/Profiles.dart';
import 'package:mdt/utils/constants.dart';
import 'package:mdt/pages/Homepage.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: const TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ).apply(
            bodyColor: textColor, // default text color
          ),
          scaffoldBackgroundColor: colorBackground // default bgrd color
          ),
      routes: {
        '/': (context) => const HomePage(),
        '/profiles': (context) =>
            const Profiles(), /*
        '/SignUp': (context) => SignUp(),
        '/Home': (context) => MyHome(),
        '/About': (context) => AboutPage(),*/
      },
    ));
