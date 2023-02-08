import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mdt/pages/Charges.dart';
import 'package:mdt/pages/Profiles.dart';
import 'package:mdt/pages/Reports.dart';
import 'package:mdt/models/constants.dart';
import 'package:mdt/pages/Homepage.dart';

void main() async{
  await Hive.initFlutter();
  var box = await Hive.openBox(dbName);


  runApp(MaterialApp(
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
        '/profiles': (context) => const Profiles(),
        '/reports': (context) => const Reports(),
        '/charges': (context) => const Charges(),
      },
    ));
}