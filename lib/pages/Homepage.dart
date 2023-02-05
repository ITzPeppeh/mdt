import 'package:flutter/material.dart';
import 'package:mdt/models/constants.dart';
import 'package:mdt/models/sidebar.dart';
import 'package:mdt/models/warrantbox.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        mySidebar(context, selectIdx: 0),
        Expanded(
            // Warrant Box
            child: Container(
          width: 150,
          color: colorBox,
          margin: const EdgeInsets.only(top: 6, bottom: 6, left: 6),
          child: Column(children: [
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Warrants',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                //SEARCH BAR TextField ?
              ],
            ),
            const WarrantBox(
              civID: 1,
              civName: 'Pippo',
              civImage:
                  'https://static.vecteezy.com/ti/vettori-gratis/p3/2158565-avatar-profilo-rosa-neon-icona-muro-mattoni-sfondo-rosa-neon-icona-vettore-vettoriale.jpg',
            ),
            const WarrantBox(
              civID: 2,
              civName: 'Peppe',
              civImage:
                  'https://static.vecteezy.com/ti/vettori-gratis/p3/2158565-avatar-profilo-rosa-neon-icona-muro-mattoni-sfondo-rosa-neon-icona-vettore-vettoriale.jpg',
            )
          ]),
        )),
        Expanded(
          // Notepad Box
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
                      'Bulletin Board',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration:
                      InputDecoration(filled: true, fillColor: sideBarColor),
                      style: TextStyle(color: textColor),
                  keyboardType: TextInputType.multiline,
                  minLines: 10,
                  maxLines: null,
                ),
              )
            ]),
          ),
        )
      ],
    ));
  }
}
