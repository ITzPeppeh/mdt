import 'package:flutter/material.dart';
import 'package:mdt/models/constants.dart';
import 'package:mdt/models/profile.dart';
import 'package:mdt/models/sidebar.dart';

class Profiles extends StatelessWidget {
  const Profiles({super.key});

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
                    )
                  ],
                ),
                const SearchProfile(
                  civName: 'John Charleston',
                  civID: 1,
                ),
                const SearchProfile(
                  civName: 'Italia Pizza',
                  civID: 2,
                )
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
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Create Profile',
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
                Row(
                  children: [
                    Container(
                        width: 200,
                        height: 200,
                        margin: const EdgeInsets.only(left: 5),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          image:
                              NetworkImage('https://i.imgur.com/ZSqeINh.png'),
                          fit: BoxFit.cover,
                        ))),
                    Column(
                      children: [
                        Text('State ID'),
                        Text('Name'),
                        Text('Profile Image URL')
                      ], //FIXME: ADD TEXTFIELDS
                    )
                  ],
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: sideBarColor,
                          hintText: 'Document content goes here...',
                          hintStyle: TextStyle(color: secondaryTextColor)),
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
                width: 150,
                //color: colorBox,
                margin: const EdgeInsets.all(6),
                child: Column(
                  children: [
                    TabProfile(title: 'Licenses'),
                    /* Da passare l'ID */
                    TabProfile(title: 'Priors'),
                  ],
                )
                /*Column(children: [
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Profiles',
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
                    minLines: 15,
                    maxLines: null,
                  ),
                )
              ]),*/
                ),
          )
        ],
      ),
    );
  }
}
