import 'package:flutter/material.dart';

const sideBarColor = Color.fromARGB(255, 39, 44, 50);
const colorBackground = Color.fromARGB(255, 54, 77, 97);
const colorBox = Color.fromARGB(255, 32, 56, 76);
const textColor = Color.fromARGB(255, 255, 255, 255);
const secondaryTextColor = Color.fromARGB(255, 71, 79, 87);

const dbName = 'mdtBOX';
const tableUsersName = 'users';

class ProfilesTexts {
  static String titleProfileName = 'Create Profile';
  static String textProfileName = '';
  static String textProfileID = '';
  static String textProfileURL = '';
  static String textProfileImageURL = 'https://i.imgur.com/ZSqeINh.png';
  static String detailsProfile = '';

  static void clearAll() {
    String user = '';
    titleProfileName = user;
    textProfileName = user;
    textProfileID = user;
    textProfileURL = user;
    textProfileImageURL = 'https://i.imgur.com/ZSqeINh.png';
    detailsProfile = user;
  }
}