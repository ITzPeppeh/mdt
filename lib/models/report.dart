import 'package:flutter/material.dart';
import 'package:mdt/models/constants.dart';

class SearchReport extends StatelessWidget {
  final title;
  final id;
  final dateCreate;
  const SearchReport(
      {super.key,
      required this.title,
      required this.id,
      required this.dateCreate});

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
                    child: Text(title, style: const TextStyle(fontSize: 13)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text("ID: ${id.toString()} - $dateCreate",
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
  final civName;
  final civID;

  const ReportProfile({super.key, required this.civID, required this.civName});

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
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                        "${widget.civName} (#${widget.civID.toString()})",
                        style: const TextStyle(fontSize: 13)),
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
