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
          Report report = MyDatabase.getReportFromId(widget.id);
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
  final String stateID;
  final Function(bool, List) notifyParent;
  bool isWarrant;
  
  ReportProfile({super.key, required this.notifyParent, required this.stateID, required this.isWarrant});

  @override
  State<ReportProfile> createState() => _ReportProfileState();
}

class _ReportProfileState extends State<ReportProfile> {

  TextEditingController stateIDTextFieldController =
      TextEditingController();

    @override
    void initState(){
      stateIDTextFieldController.text = widget.stateID;
      super.initState();
    }

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
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                        width: 200,
                        child: TextField(
                          controller: stateIDTextFieldController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              labelStyle: TextStyle(color: textColor),
                              labelText: 'State ID'),
                        )),
                  ),
                  const Expanded(child: SizedBox()),
                  IconButton(
                    onPressed: () {
                      widget.notifyParent(true,[stateIDTextFieldController.text]);
                    },
                    icon: const Icon(Icons.delete),
                    color: textColor,
                    splashColor: transColor,
                    highlightColor: transColor,
                  ),
                  IconButton(
                    onPressed: () {
                      widget.notifyParent(false, [stateIDTextFieldController.text, widget.isWarrant]);
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
                  Checkbox(
                    value: widget.isWarrant,
                    onChanged: (value) {

                      setState(() {
                        widget.isWarrant = value!;
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
