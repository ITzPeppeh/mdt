import 'package:flutter/material.dart';
import 'package:mdt/models/constants.dart';

class WarrantBox extends StatelessWidget {
  final String civName;
  final String civImage;
  final int civID;

  const WarrantBox(
      {super.key,
      required this.civID,
      required this.civName,
      required this.civImage});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          margin: const EdgeInsets.all(5),
          height: 140,
          color: sideBarColor,
          child: Row(
            children: [
              Container(
                  width: 130,
                  height: 130,
                  margin: const EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(civImage),
                    fit: BoxFit.cover,
                  ))),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(civName, style: const TextStyle(fontSize: 15)),
                  ),
                  const Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("ID: ${civID.toString()}",
                        style: const TextStyle(fontSize: 15)),
                  )
                ],
              )
            ],
          ),
        ))
      ],
    );
  }
}
