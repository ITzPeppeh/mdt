import 'package:flutter/material.dart';
import 'package:mdt/models/constants.dart';
import 'package:mdt/models/sidebar.dart';
import 'package:mdt/models/database.dart';

class Charges extends StatefulWidget {
  final String chargeName;
  const Charges({super.key,required this.chargeName,});

  @override
  State<Charges> createState() => _ChargesState();
}

class _ChargesState extends State<Charges> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        mySidebar(context, selectIdx: 3),
        Expanded(
            child: Container(
                margin: const EdgeInsets.all(5),
                color: colorBox,
                child: Column(
                  children: const [
                    TextField(
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: textColor),
                          labelText: 'Search',
                          prefixIcon: Icon(Icons.search)),
                    )
                  ],
                )))
      ]),
    );
  }
}

class SearchCharge extends StatefulWidget {
  const SearchCharge({super.key});

  @override
  State<SearchCharge> createState() => _SearchChargeState();
}

class _SearchChargeState extends State<SearchCharge> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}