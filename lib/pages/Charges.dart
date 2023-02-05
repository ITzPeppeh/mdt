import 'package:flutter/material.dart';
import 'package:mdt/models/constants.dart';
import 'package:mdt/models/sidebar.dart';

class Charges extends StatelessWidget {
  const Charges({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        mySidebar(context,selectIdx: 3),
        Expanded(child: Container(margin: EdgeInsets.all(5),color: colorBox,))
      ]),
    );
  }
}