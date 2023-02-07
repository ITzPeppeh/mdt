import 'package:flutter/material.dart';
import 'package:mdt/models/constants.dart';
import 'package:mdt/models/profile.dart';
import 'package:mdt/models/sidebar.dart';
import 'package:mdt/models/database.dart';

class Profiles extends StatefulWidget {
  const Profiles({super.key});

  @override
  State<Profiles> createState() => _ProfilesState();
}

class _ProfilesState extends State<Profiles> {
  List _reportWidgetList = [];
  List _foundUsers = [];
  TextEditingController stateIdTextFieldController = TextEditingController();
  TextEditingController fullNameTextFieldController = TextEditingController();
  TextEditingController imageURLTextFieldController = TextEditingController();
  TextEditingController detailsTextFieldController = TextEditingController();

  refreshProfileReports() {
    setState(() {
      _reportWidgetList = [];
      if (ProfilesTexts.textProfileID == '') return;

      int id = int.parse(ProfilesTexts.textProfileID);

      for (var crim in MyDatabase.listCrimReports) {
        if (crim.idCiv == id) {
          _reportWidgetList
              .add(TabProfile(title: "Appears in report ID: ${crim.idReport}"));
        }
      }
    });
  }

  @override
  void initState() {
    MyDatabase.initDatabase();
    _foundUsers = MyDatabase.listUsers;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          mySidebar(context, selectIdx: 1),
          Expanded(
            // All Profiles Box
            child: Container(
              color: colorBox,
              margin: const EdgeInsets.all(6),
              child: Column(children: [
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Profiles',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                TextField(
                  decoration: const InputDecoration(
                      labelStyle: TextStyle(color: textColor),
                      labelText: 'Search',
                      suffixIcon: Icon(Icons.search)),
                  onChanged: (textValue) {
                    List results = [];
                    if (textValue.isEmpty) {
                      results = MyDatabase.listUsers;
                    } else {
                      results = MyDatabase.listUsers
                          .where((element) => element.fullName
                              .toLowerCase()
                              .contains(textValue.toLowerCase()))
                          .toList();
                    }
                    setState(() {
                      _foundUsers = results;
                    });
                  },
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _foundUsers.length,
                  itemBuilder: (context, index) {
                    List data = _foundUsers;
                    return SearchProfile(
                      civID: data[index].id,
                      civName: data[index].fullName,
                      notifyParent: refreshProfileReports,
                    );
                  },
                ),
              ]),
            ),
          ),
          Expanded(
            // Report Box
            child: Container(
              width: 150,
              color: colorBox,
              margin: const EdgeInsets.all(6),
              child: Column(children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        ProfilesTexts.titleProfileName,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _reportWidgetList = [];
                          ProfilesTexts.clearAll();
                        });
                      },
                      icon: const Icon(Icons.create_new_folder),
                      color: textColor,
                      splashColor: transColor,
                      highlightColor: transColor,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          MyDatabase.delUserFromId(int.parse(
                              stateIdTextFieldController.text == ''
                                  ? '-1'
                                  : stateIdTextFieldController.text));
                          _foundUsers = MyDatabase.listUsers;

                          _reportWidgetList = [];
                          ProfilesTexts.clearAll();
                        });
                      },
                      icon: const Icon(Icons.delete),
                      color: textColor,
                      splashColor: transColor,
                      highlightColor: transColor,
                    ),
                    IconButton(
                      onPressed: () {
                        if (stateIdTextFieldController.text == '') return;
                        setState(() {
                          MyDatabase.addOrUpdateUser(Civ(
                              id: int.parse(
                                  stateIdTextFieldController.text == ''
                                      ? '-1'
                                      : stateIdTextFieldController.text),
                              fullName: fullNameTextFieldController.text,
                              isWarant: false,
                              imageProfileURL: imageURLTextFieldController.text,
                              detailsProfile: detailsTextFieldController.text));

                          _foundUsers = MyDatabase.listUsers;
                          _reportWidgetList = [];
                          ProfilesTexts.clearAll();
                        });
                      },
                      icon: const Icon(Icons.save),
                      color: textColor,
                      splashColor: transColor,
                      highlightColor: transColor,
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                        width: 200,
                        height: 200,
                        margin: const EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image:
                              NetworkImage(ProfilesTexts.textProfileImageURL),
                          fit: BoxFit.cover,
                        ))),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  width: 200,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: stateIdTextFieldController
                                      ..text = ProfilesTexts.textProfileID,
                                    decoration: const InputDecoration(
                                        labelStyle: TextStyle(color: textColor),
                                        labelText: 'State ID'),
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  width: 200,
                                  child: TextField(
                                    controller: fullNameTextFieldController
                                      ..text = ProfilesTexts.textProfileName,
                                    decoration: const InputDecoration(
                                        labelStyle: TextStyle(color: textColor),
                                        labelText: 'Full Name'),
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  width: 200,
                                  child: TextField(
                                    controller: imageURLTextFieldController
                                      ..text = ProfilesTexts.textProfileURL,
                                    decoration: const InputDecoration(
                                        labelStyle: TextStyle(color: textColor),
                                        labelText: 'Profile Image URL'),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: detailsTextFieldController
                        ..text = ProfilesTexts.detailsProfile,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: sideBarColor,
                          hintText: 'Document content goes here...',
                          hintStyle: TextStyle(color: secondaryTextColor)),
                      style: const TextStyle(color: textColor),
                      keyboardType: TextInputType.multiline,
                      minLines: 25,
                      maxLines: null,
                    ),
                  ),
                )
              ]),
            ),
          ),
          Expanded(
            child: Container(
              width: 150,
              color: colorBox,
              margin: const EdgeInsets.all(6),
              child: Column(children: [
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Related Reports',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _reportWidgetList.length,
                  itemBuilder: (context, index) {
                    return _reportWidgetList[index];
                  },
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
