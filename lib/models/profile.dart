import 'package:flutter/material.dart';
import 'package:mdt/models/constants.dart';

class TabProfile extends StatelessWidget {
  final title;
  const TabProfile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          margin: const EdgeInsets.only(bottom: 5),
          height: 100,
          color: colorBox,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ))
      ],
    );
  }
}

class SearchProfile extends StatelessWidget {
  final String civName;
  final int civID;

  const SearchProfile({
    super.key,
    required this.civID,
    required this.civName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          print("Tapped $civName - $civID");
        },
        child: Row(
          children: [
            Expanded(
                child: Container(
              height: 50,
              color: sideBarColor,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(civName, style: const TextStyle(fontSize: 13)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text("ID: ${civID.toString()}",
                        style: const TextStyle(fontSize: 13)),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
