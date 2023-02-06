import 'package:flutter/material.dart';
import 'package:mdt/models/constants.dart';
import 'package:mdt/models/profile.dart';
import 'package:mdt/models/sidebar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mdt/models/database.dart';

class Profiles extends StatefulWidget {
  const Profiles({super.key});

  @override
  State<Profiles> createState() => _ProfilesState();
}

class _ProfilesState extends State<Profiles> {
  final _myDB = Hive.box(dbName);
  MyDatabase db = MyDatabase();
  refresh() {
    setState(() {});
  }

  TextEditingController _stateIdTextFieldController = TextEditingController();
  TextEditingController _fullNameTextFieldController = TextEditingController();
  TextEditingController _imageURLTextFieldController = TextEditingController();
  TextEditingController _detailsTextFieldController = TextEditingController();

  @override
  void initState() {
    if (_myDB.get(tableUsersName) == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    _foundUsers = MyDatabase.listUsers;
    super.initState();
  }

  List _foundUsers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          mySidebar(context, selectIdx: 1),
          Expanded(
            // Notepad Box
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
                      notifyParent: refresh,
                    );
                  },
                ),
              ]),
            ),
          ),
          Expanded(
            // Notepad Box
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
                          ProfilesTexts.clearAll();
                        });
                      },
                      icon: const Icon(Icons.create_new_folder),
                      color: textColor,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          db.deleteUserFromId(2);
                          db.updateDatabase();
                          ProfilesTexts.clearAll();
                        });
                        /*MyDatabase.deleteUserFromId(
                              int.parse(_stateIdTextFieldController.text));
                          setState(() {
                            ProfilesTexts.clearAll();
                          });*/
                      },
                      icon: const Icon(Icons.delete),
                      color: textColor,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    IconButton(
                      onPressed: () {
                        db.createOrUpdateUser(Civ(
                            id: int.parse(_stateIdTextFieldController.text),
                            fullName: _fullNameTextFieldController.text,
                            isWarant: false,
                            imageProfileURL: _imageURLTextFieldController.text,
                            detailsProfile: _detailsTextFieldController.text));
                        setState(() {
                          print('object2');
                        });
                      },
                      icon: const Icon(Icons.save),
                      color: textColor,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
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
                                    controller: _stateIdTextFieldController
                                      ..text = ProfilesTexts.textProfileName,
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
                                    controller: _fullNameTextFieldController
                                      ..text = ProfilesTexts.textProfileID,
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
                                    controller: _imageURLTextFieldController
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
                      controller: _detailsTextFieldController
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
                //color: colorBox,
                margin: const EdgeInsets.all(6),
                child: Column(
                  children: const [
                    TabProfile(title: 'Licenses'),
                    /* Da passare l'ID */
                    TabProfile(title: 'Priors'),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
