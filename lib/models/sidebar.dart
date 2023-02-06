import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:mdt/models/constants.dart';

SidebarX mySidebar(BuildContext context, {int selectIdx = 0}) {
  return SidebarX(
    controller: SidebarXController(selectedIndex: selectIdx),
    theme: const SidebarXTheme(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              sideBarColor,
              sideBarColor
            ],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20)
          )
      ),
      iconTheme: IconThemeData(color: Colors.white),
      selectedTextStyle: TextStyle(color: Colors.white),
      padding: EdgeInsets.all(5)
    ),
    extendedTheme: const SidebarXTheme(width: 250),
    footerDivider: Divider(color: Colors.white.withOpacity(0.8), height: 1),
    items: [
      SidebarXItem(icon: Icons.home, label: 'Dashboard', onTap: () {
        Navigator.pushNamed(context, '/');
      },),
      SidebarXItem(icon: Icons.supervised_user_circle, label: 'Profiles', onTap: () {
        Navigator.pushNamed(context, '/profiles');
      },),
      SidebarXItem(icon: Icons.edit_note, label: 'Reports', onTap: () {
        Navigator.pushNamed(context, '/reports');
      },),
      SidebarXItem(icon: Icons.filter_list, label: 'Charges', onTap: () {
        Navigator.pushNamed(context, '/charges');
      },),
    ],
  );
}