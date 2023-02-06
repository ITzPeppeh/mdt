import 'package:flutter/material.dart';
import 'package:mdt/models/constants.dart';
import 'package:mdt/models/report.dart';
import 'package:mdt/models/sidebar.dart';
import 'package:mdt/models/database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  final _myDB = Hive.box(dbName);
  MyDatabase db = MyDatabase();
  refresh() {
    setState(() {});
  }

  TextEditingController _titleReportTextFieldController =
      TextEditingController();
  TextEditingController _detailsReportTextFieldController =
      TextEditingController();

  @override
  void initState() {
    if (_myDB.get(tableReportsName) == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    _foundReports = MyDatabase.listReports;
    super.initState();
  }

  List _foundReports = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        mySidebar(context, selectIdx: 2),
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
                      'Reports',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
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
                    results = MyDatabase.listReports;
                  } else {
                    results = MyDatabase.listReports
                        .where((element) => element.reportName
                            .toLowerCase()
                            .contains(textValue.toLowerCase()))
                        .toList();
                  }

                  setState(() {
                    _foundReports = results;
                  });
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _foundReports.length,
                itemBuilder: (context, index) {
                  List data = _foundReports;
                  return SearchReport(
                    title: data[index].reportName,
                    id: data[index].id,
                    dateCreate: data[index].dateCreated,
                    notifyParent: refresh,
                  );
                },
              ),
            ]),
          ),
        ),
        Expanded(
          child: Container(
            color: colorBox,
            margin: const EdgeInsets.all(6),
            child: Column(children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      ReportsTexts.titleReportName,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          ReportsTexts.clearAll();
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
                          ReportsTexts.clearAll();
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
                      debugPrint('salvo');
                    },
                    icon: const Icon(Icons.save),
                    color: textColor,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  )
                ],
              ),
              TextField(
                controller: _titleReportTextFieldController
                  ..text = ReportsTexts.textReportTitle,
                style: const TextStyle(color: textColor),
                decoration: const InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: textColor),
                  prefixIcon: Icon(
                    Icons.carpenter,
                    color: textColor,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _detailsReportTextFieldController
                      ..text = ReportsTexts.textDetails,
                    decoration: const InputDecoration(
                        filled: true, fillColor: sideBarColor),
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
            color: colorBox,
            margin: const EdgeInsets.all(6),
            child: Column(children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Add Criminal Scum',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                    onPressed: () {
                      debugPrint('addo');
                    },
                    icon: const Icon(Icons.add),
                    color: textColor,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  )
                ],
              ),
              ReportProfile(
                civName: 'John Charleston',
                civID: 1,
              ),
              ReportProfile(
                civName: 'Italia Pizza',
                civID: 2,
              )
            ]),
          ),
        ),
      ]),
    );
  }
}
