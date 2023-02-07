import 'package:flutter/material.dart';
import 'package:mdt/models/constants.dart';
import 'package:mdt/models/report.dart';
import 'package:mdt/models/sidebar.dart';
import 'package:mdt/models/database.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  List _foundReports = [];
  List _crimWidgetList = [];
  TextEditingController titleReportTextFieldController =
      TextEditingController();
  TextEditingController detailsReportTextFieldController =
      TextEditingController();

  refreshProfileReps() {
    setState(() {
      _crimWidgetList = [];
      if (ReportsTexts.textReportID == '') return;

      int id = int.parse(ReportsTexts.textReportID);

      for (var crim in MyDatabase.listCrimReports) {
        if (crim.idReport == id) {
          _crimWidgetList.add(ReportProfile(
            notifyParent: addCrimToReport,
            stateID: crim.idCiv.toString(),
            isWarrant: crim.isWarrant,
          ));
        }
      }
    });
  }

  addCrimToReport(bool deleteReport, List civAndWarrant) {
    /* 2in1 */
    if (ReportsTexts.textReportID == '') return;
    if (!deleteReport) {
      if (civAndWarrant[0] == '') return;

      MyDatabase.addCrimReport(Arrested(
          idReport: int.parse(ReportsTexts.textReportID),
          idCiv: int.parse(civAndWarrant[0]),
          isWarrant: civAndWarrant[1]));

      MyDatabase.updateWarrant(int.parse(civAndWarrant[0]), civAndWarrant[1]);

      setState(() {
        ReportsTexts.clearAll();
        /*TODO: DELETE ONLY HIS WIDGET(?)*/
        _crimWidgetList.clear();
      });
    } else {
      MyDatabase.delCrimReport(ReportsTexts.textReportID);

      setState(() {
        ReportsTexts.clearAll();
        _crimWidgetList.clear();
      });
    }
  }

  @override
  void initState() {
    MyDatabase.initDatabase();
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
                    notifyParent: refreshProfileReps,
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
                    splashColor: transColor,
                    highlightColor: transColor,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        MyDatabase.deleteReportFromId(int.parse(
                            ReportsTexts.textReportID == ''
                                ? '-1'
                                : ReportsTexts.textReportID));
                        _foundReports = MyDatabase.listReports;
                        ReportsTexts.clearAll();
                      });
                    },
                    icon: const Icon(Icons.delete),
                    color: textColor,
                    splashColor: transColor,
                    highlightColor: transColor,
                  ),
                  IconButton(
                    onPressed: () {
                      if (ReportsTexts.textReportTitle == '') return;
                      setState(() {
                        MyDatabase.addOrUpdateReport(Report(
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
                    splashColor: transColor,
                    highlightColor: transColor,
                  )
                ],
              ),
              TextField(
                onChanged: (value) {
                  ReportsTexts.textReportTitle = value;
                },
                controller: titleReportTextFieldController
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
                    controller: detailsReportTextFieldController
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
                          notifyParent: addCrimToReport,
                          stateID: '',
                          isWarrant: false,
                        ));
                      });
                    },
                    icon: const Icon(Icons.add),
                    color: textColor,
                    splashColor: transColor,
                    highlightColor: transColor,
                  )
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _crimWidgetList.length,
                itemBuilder: (context, index) {
                  return _crimWidgetList[index];
                },
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
