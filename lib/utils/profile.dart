import 'package:flutter/material.dart';
import 'package:mdt/utils/constants.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
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
          debugPrint('Coap');
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
