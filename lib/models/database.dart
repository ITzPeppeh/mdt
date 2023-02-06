import 'package:hive_flutter/hive_flutter.dart';
import 'package:mdt/models/constants.dart';

class MyDatabase {
  static List<Civ> listUsers = [];
  static List<Report> listReports = [];

  final _myDB = Hive.box(dbName);

  List getWarrants() {
    List temps = [];
    for (var i = 0; i < listUsers.length; i++) {
      if (listUsers[i].isWarant) {
        temps.add({
          'fullName': listUsers[i].fullName,
          'imageURL': listUsers[i].imageProfileURL,
          'id': listUsers[i].id
        });
      }
    }
    return temps;
  }

  static Civ getFromID(int ID) {
    Civ temp = listUsers.firstWhere((element) => element.id == ID);
    return temp;
  }

  void deleteUserFromId(int ID) {
    int a = listUsers.indexWhere((element) => element.id == ID);
    if (a != -1) {
      listUsers = List.from(listUsers)..removeAt(a);
    }
  }

  void deleteReportFromId(int ID) {
    int a = listReports.indexWhere((element) => element.id == ID);
    if (a != -1) {
      listReports = List.from(listReports)..removeAt(a);
    }
  }

  void createOrUpdateUser(Civ newuser) {
    int ind = listUsers.indexWhere((element) => element.id == newuser.id);
    if (ind == -1) {
      listUsers.add(newuser); //Increment ID
    } else {
      listUsers[ind] = Civ(
          id: listUsers[ind].id,
          fullName: newuser.fullName,
          isWarant: listUsers[ind].isWarant,
          imageProfileURL: newuser.imageProfileURL,
          detailsProfile: newuser.detailsProfile);
    }
  }



  void createOrUpdateReport(Report newreport) {
    int ind = listReports.indexWhere((element) => element.id == newreport.id);
    if (ind == -1) {
      int newid = listReports.last.id + 1;
      listReports.add(Report(id: newid, reportName: newreport.reportName, dateCreated: newreport.dateCreated, detailsReport: newreport.detailsReport)); //Increment ID
    } else {
      listReports[ind] = Report(
          id: listReports[ind].id,
          reportName: newreport.reportName,
          detailsReport: newreport.detailsReport,
          dateCreated: listReports[ind].dateCreated);
    }
  }

  void createInitialData() {
    listUsers = [
      Civ(
          detailsProfile: 'suca',
          id: 1,
          fullName: 'Mario Rossi',
          isWarant: false,
          imageProfileURL:
              'https://static.vecteezy.com/ti/vettori-gratis/p3/2158565-avatar-profilo-rosa-neon-icona-muro-mattoni-sfondo-rosa-neon-icona-vettore-vettoriale.jpg'),
      Civ(
          detailsProfile: 'ammazzati',
          id: 2,
          fullName: 'Fabio Neri',
          isWarant: true,
          imageProfileURL:
              'https://static.vecteezy.com/ti/vettori-gratis/p3/2158565-avatar-profilo-rosa-neon-icona-muro-mattoni-sfondo-rosa-neon-icona-vettore-vettoriale.jpg'),
      Civ(
          detailsProfile: 'jay',
          id: 3,
          fullName: 'Jessico Calcetto',
          isWarant: true,
          imageProfileURL: 'https://i.imgur.com/YTnxeEy.gif'),
      Civ(
          detailsProfile: 'ok',
          id: 4,
          fullName: 'Pino Dangelo',
          isWarant: false,
          imageProfileURL:
              'https://static.vecteezy.com/ti/vettori-gratis/p3/2158565-avatar-profilo-rosa-neon-icona-muro-mattoni-sfondo-rosa-neon-icona-vettore-vettoriale.jpg'),
    ];
    listReports = [
      Report(
          id: 1000,
          reportName: 'A BOOST',
          dateCreated: DateTime.utc(1989, 11, 9),
          detailsReport: 'Suca'),
      Report(
          id: 1001,
          reportName: 'Karoline Flexx - Evading',
          dateCreated: DateTime.utc(2002, 6, 8),
          detailsReport: 'Ciuccia'),
      Report(
          id: 1002,
          reportName: 'Futo Boost - Grand Theft Auto',
          dateCreated: DateTime.utc(2015, 9, 5),
          detailsReport: 'Cazzi'),
    ];
  }

  void loadData() {
    listUsers = _myDB.get(tableUsersName);
    listReports = _myDB.get(tableReportsName);
  }

  void updateDatabase() {
    _myDB.put(tableUsersName, listUsers);
    _myDB.put(tableReportsName, listReports);
  }

  static Report getReportFromID(int ID) {
    Report temp = listReports.firstWhere((element) => element.id == ID);
    return temp;
  }

}

class Civ {
  final int id;
  final String fullName;
  final bool isWarant;
  final String imageProfileURL;
  final String detailsProfile;

  const Civ({
    required this.id,
    required this.fullName,
    required this.isWarant,
    required this.imageProfileURL,
    required this.detailsProfile,
  });
}

class Report {
  final int id;
  final String reportName;
  final String detailsReport;
  final DateTime dateCreated;

  

  const Report(
      {required this.id, required this.reportName, required this.dateCreated, required this.detailsReport});
}

class Charge{
  final String chargeName;
  const Charge({required this.chargeName});
}

List<Charge> listCharges = [
  Charge(chargeName: 'Criminal Possession of a Firearm'),
  Charge(chargeName: 'Criminal Sale of an illegal weapon'),
  Charge(chargeName: 'Weapons Trafficking'),
  Charge(chargeName: 'Drug Trafficking'),
  Charge(chargeName: 'Human Trafficking'),
  Charge(chargeName: 'Serial Assaults and Killings'),
  Charge(chargeName: 'Murder of a Government Employee'),
  Charge(chargeName: 'Gang Related Shooting'),
  Charge(chargeName: 'Reckless Endangement'),
];