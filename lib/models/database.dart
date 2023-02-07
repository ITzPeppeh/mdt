import 'package:hive_flutter/hive_flutter.dart';
import 'package:mdt/models/constants.dart';

class MyDatabase {
  static List<Civ> listUsers = [];
  static List<Report> listReports = [];
  static List<Arrested> listCrimReports = [];
  static Box myDB = Hive.box(dbName);

  static void initDatabase() {
    if (myDB.get(tableUsersName) == null) {
      createInitialData(tableUsersName);
    } else {
      loadData(tableUsersName);
    }
    if (myDB.get(tableReportsName) == null) {
      createInitialData(tableReportsName);
    } else {
      loadData(tableReportsName);
    }
    if (myDB.get(tableCrimReportsName) == null) {
      createInitialData(tableCrimReportsName);
    } else {
      loadData(tableCrimReportsName);
    }
  }

  static void createInitialData(String tableName) {
    switch (tableName) {
      case tableUsersName:
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
        break;
      case tableReportsName:
        listReports = [
          Report(
            id: 1000,
            reportName: 'A BOOST',
            dateCreated: DateTime.utc(1989, 11, 9),
            detailsReport: 'Suca',
          ),
          Report(
            id: 1001,
            reportName: 'Karoline Flexx - Evading',
            dateCreated: DateTime.utc(2002, 6, 8),
            detailsReport: 'Ciuccia',
          ),
          Report(
            id: 1002,
            reportName: 'Futo Boost - Grand Theft Auto',
            dateCreated: DateTime.utc(2015, 9, 5),
            detailsReport: 'Cazzi',
          ),
        ];
        break;
      case tableCrimReportsName:
        listCrimReports = [];
      break;
    }
  }

  static void loadData(String tableName) {
    switch (tableName) {
      case tableUsersName:
        listUsers = myDB.get(tableUsersName);
        break;
      case tableReportsName:
        listReports = myDB.get(tableReportsName);
        break;
      case tableCrimReportsName:
        listCrimReports = myDB.get(tableCrimReportsName);
        break;
    }
  }

  static List getWarrants() {
    List temps = [];
    for (var i = 0; i < listUsers.length; i++) {
      if (listUsers[i].isWarant) {
        temps.add({
          'fullName': listUsers[i].fullName,
          'imageURL': listUsers[i].imageProfileURL,
          'id': listUsers[i].id,
        });
      }
    }
    return temps;
  }

  static void updateWarrant(int civ, bool war) {
    for (var element in listUsers) {
      if (element.id == civ && element.isWarant != war) {
        element.isWarant = war;
      }
    }
  }

  static Civ getUserFromId(int ID) {
    Civ temp = listUsers.firstWhere((element) => element.id == ID);
    return temp;
  }

  static void addOrUpdateUser(Civ newuser) {
    int ind = listUsers.indexWhere((element) => element.id == newuser.id);
    if (ind == -1) {
      listUsers.add(newuser);
    } else {
      listUsers[ind] = Civ(
          id: listUsers[ind].id,
          fullName: newuser.fullName,
          isWarant: listUsers[ind].isWarant,
          imageProfileURL: newuser.imageProfileURL,
          detailsProfile: newuser.detailsProfile);
    }
  }

  static void delUserFromId(int ID) {
    int a = listUsers.indexWhere((element) => element.id == ID);
    if (a != -1) {
      listUsers = List.from(listUsers)..removeAt(a);
    }
  }

  static Report getReportFromId(int ID) {
    Report temp = listReports.firstWhere((element) => element.id == ID);
    return temp;
  }

  static void addOrUpdateReport(Report newreport) {
    int ind = listReports.indexWhere((element) => element.id == newreport.id);
    if (ind == -1) {
      int newid = listReports.last.id + 1;
      listReports.add(Report(
        id: newid,
        reportName: newreport.reportName,
        dateCreated: newreport.dateCreated,
        detailsReport: newreport.detailsReport,
      ));
    } else {
      listReports[ind] = Report(
        id: listReports[ind].id,
        reportName: newreport.reportName,
        detailsReport: newreport.detailsReport,
        dateCreated: listReports[ind].dateCreated,
      );
    }
  }

  static void deleteReportFromId(int ID) {
    int a = listReports.indexWhere((element) => element.id == ID);
    if (a != -1) {
      listReports = List.from(listReports)..removeAt(a);
    }
  }

  static addCrimReport(Arrested newcrim) {
    listCrimReports.add(newcrim);
  }

  static delCrimReport(String idrep) {
  listCrimReports.removeWhere((element) =>
          element.idReport.toString() == idrep);
  }

  void updateDatabase() {
    myDB.put(tableUsersName, listUsers);
    myDB.put(tableReportsName, listReports);
    myDB.put(tableCrimReportsName, listCrimReports);
  }
}

class Civ {
  final int id;
  final String fullName;
  bool isWarant;
  final String imageProfileURL;
  final String detailsProfile;

  Civ({
    required this.id,
    required this.fullName,
    required this.isWarant,
    required this.imageProfileURL,
    required this.detailsProfile,
  });
}

class Report {
  int id;
  String reportName;
  String detailsReport;
  DateTime dateCreated;

  Report(
      {required this.id,
      required this.reportName,
      required this.dateCreated,
      required this.detailsReport});
}

class Arrested {
  final int idReport;
  final int idCiv;
  final bool isWarrant;
  Arrested(
      {required this.idReport, required this.idCiv, required this.isWarrant});
}

class Charge {
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
