import 'package:flutter/material.dart';
import 'package:mdt/models/constants.dart';
import 'package:mdt/models/database.dart';

class TabProfile extends StatefulWidget {
  final title;
  const TabProfile({super.key, required this.title});

  @override
  State<TabProfile> createState() => _TabProfileState();
}

class _TabProfileState extends State<TabProfile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {Navigator.pushNamed(context, '/reports');},
        child: Row(
          children: [
            Expanded(
                child: Container(
              height: 50,
              color: sideBarColor,
              child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                      child: Text(widget.title,
                          style: const TextStyle(fontSize: 18)),
                    ),
                  ),
            ))
          ],
        ),
      ),
    );
  }
}

class SearchProfile extends StatefulWidget {
  final String civName;
  final int civID;
  final Function() notifyParent;

  const SearchProfile({
    super.key,
    required this.civID,
    required this.civName,
    required this.notifyParent,
  });

  @override
  State<SearchProfile> createState() => _SearchProfileState();
}

class _SearchProfileState extends State<SearchProfile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          Civ user = MyDatabase.getUserFromId(widget.civID);
          ProfilesTexts.titleProfileName = user.fullName;
          ProfilesTexts.textProfileName = user.fullName;
          ProfilesTexts.textProfileID = user.id.toString();
          ProfilesTexts.textProfileURL = user.imageProfileURL;
          ProfilesTexts.textProfileImageURL = user.imageProfileURL;
          ProfilesTexts.detailsProfile = user.detailsProfile;
          widget.notifyParent();
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
                    child: Text(widget.civName,
                        style: const TextStyle(fontSize: 13)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text("ID: ${widget.civID.toString()}",
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
