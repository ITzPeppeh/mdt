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
  List _foundReports = [];
  List _crimWidgetList = [];

  refresh() {
    setState(() {
      _crimWidgetList = [];
      if (ReportsTexts.textReportID == '') return;

      int id = int.parse(ReportsTexts.textReportID);
      for (var i = 0; i < MyDatabase.listCrimReports.length; i++) {
        if (MyDatabase.listCrimReports[i].idReport == id) {
          _crimWidgetList.add(ReportProfile(
              notifyParent: addToReport,
              stateID: MyDatabase.listCrimReports[i].idCiv.toString()));
        }
      }
    });
  }

  addToReport(bool deleteReport, List lol) {
    if (!deleteReport) {
      if (ReportsTexts.textReportID == '') return;
      if (lol[0] == '') return;
      print(lol[1]);
      MyDatabase.listCrimReports.add(Arrested(
          idReport: int.parse(ReportsTexts.textReportID),
          idCiv: int.parse(lol[0]),
          isWarrant: lol[1]));
      
      MyDatabase.listUsers.forEach((element) {
        print('---');
        print(element.id);
        print(lol[1]);
        print('--');
         if(element.id == int.parse(lol[0]) && element.isWarant != lol[1]) {
          print('dentro');
        element.isWarant = lol[1];}});
      setState(() {
        ReportsTexts.clearAll();
        /*TODO: DELETE ONLY HIS WIDGET(?)*/
        _crimWidgetList.clear();
      });
    } else {
      if (ReportsTexts.textReportID == '') return;

      MyDatabase.listCrimReports.removeWhere((element) =>
          element.idReport.toString() == ReportsTexts.textReportID);

      setState(() {
        ReportsTexts.clearAll();
        _crimWidgetList.clear();
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        mySidebar(context, selectIdx: 2),
        Expanded(
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
                        _crimWidgetList.clear();
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
                        db.deleteReportFromId(int.parse(
                            ReportsTexts.textReportID == ''
                                ? '-1'
                                : ReportsTexts.textReportID));
                        _foundReports = MyDatabase.listReports;
                        ReportsTexts.clearAll();
                      });
                    },
                    icon: const Icon(Icons.delete),
                    color: textColor,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  IconButton(
                    onPressed: () {
                      if (ReportsTexts.textReportTitle == '') return;
                      setState(() {
                        db.createOrUpdateReport(Report(
                            id: int.parse(ReportsTexts.textReportID == ''
                                ? '-1'
                                : ReportsTexts.textReportID),
                            reportName: ReportsTexts.textReportTitle,
                            dateCreated: DateTime.now(),
                            detailsReport: ReportsTexts.textDetails));
                        _foundReports = MyDatabase.listReports;
                        ReportsTexts.clearAll();
                      });
                    },
                    icon: const Icon(Icons.save),
                    color: textColor,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  )
                ],
              ),
              TextField(
                onChanged: (value) {
                  ReportsTexts.textReportTitle = value;
                },
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
                    onChanged: (value) {
                      ReportsTexts.textDetails = value;
                    },
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
                      setState(() {
                        _crimWidgetList.add(ReportProfile(
                            notifyParent: addToReport, stateID: ''));
                      });
                    },
                    icon: const Icon(Icons.add),
                    color: textColor,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  )
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _crimWidgetList.length,
                itemBuilder: (context, index) {
                  return _crimWidgetList[
                      index];
                },
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
