import 'package:flutter/material.dart';
import 'package:mdt/models/constants.dart';
import 'package:mdt/models/database.dart';

class SearchReport extends StatefulWidget {
  final title;
  final id;
  final dateCreate;
  final Function() notifyParent;

  const SearchReport({
    super.key,
    required this.title,
    required this.id,
    required this.dateCreate,
    required this.notifyParent,
  });

  @override
  State<SearchReport> createState() => _SearchReportState();
}

class _SearchReportState extends State<SearchReport> {
  String dateToString = '';

  @override
  void initState() {
    dateToString =
        "${widget.dateCreate.day}-${widget.dateCreate.month}-${widget.dateCreate.year}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          Report report = MyDatabase.getReportFromID(widget.id);
          ReportsTexts.titleReportName =
              'Edit Incident (#${report.id.toString()})';
          ReportsTexts.textReportTitle = report.reportName;
          ReportsTexts.textReportID = report.id.toString();
          ReportsTexts.textDetails = report.detailsReport;
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
                    child: Text(widget.title,
                        style: const TextStyle(fontSize: 13)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text("ID: ${widget.id.toString()} - $dateToString",
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

class ReportProfile extends StatefulWidget {
  const ReportProfile({super.key});

  @override
  State<ReportProfile> createState() => _ReportProfileState();
}

class _ReportProfileState extends State<ReportProfile> {
  bool? isWarrant = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          margin: const EdgeInsets.only(bottom: 5),
          height: 150,
          color: sideBarColor,
          child: Column(
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelStyle: TextStyle(color: textColor),
                              labelText: 'State ID'),
                        )),
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                    onPressed: () {
                      debugPrint('elimino prof');
                    },
                    icon: const Icon(Icons.delete),
                    color: textColor,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  IconButton(
                    onPressed: () {
                      debugPrint('salvo prof');
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
                  Checkbox(
                    value: isWarrant,
                    onChanged: (value) {
                      setState(() {
                        isWarrant = value;
                      });
                    },
                  ),
                  const Text('Warrant for Arrest')
                ],
              )

              //
            ],
          ),
        ))
      ],
    );
  }
}
