import 'package:flutter/material.dart';
import 'package:mdt/models/constants.dart';
import 'package:mdt/models/report.dart';
import 'package:mdt/models/sidebar.dart';

class Reports extends StatelessWidget {
  const Reports({super.key});

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
              const SearchReport(
                title: 'John Charleston',
                id: 1,
                dateCreate: '1234',
              ),
              const SearchReport(
                title: 'Italia Pizza',
                id: 2,
                dateCreate: '23132',
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
                      'Edit Report (#12345)',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
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
              const TextField(
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: textColor),
                  prefixIcon: Icon(
                    Icons.carpenter,
                    color: textColor,
                  ),
                ),
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    decoration:
                        InputDecoration(filled: true, fillColor: sideBarColor),
                    style: TextStyle(color: textColor),
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
