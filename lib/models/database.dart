import 'package:hive_flutter/hive_flutter.dart';
import 'package:mdt/models/constants.dart';

class MyDatabase {
  List<Civ> listUsers = [];

  final _myDB = Hive.box(dbName);

  List getWarrants() {
    List temps = [];
    for (var i = 0; i < listUsers.length; i++) {
      if(listUsers[i].isWarant) {
        temps.add({'fullName' : listUsers[i].fullName, 'imageURL' : listUsers[i].imageProfileURL, 'id' : listUsers[i].id});
      }
    }
    return temps;
  }

  void createInitialData() {
    listUsers = const [
      Civ(id: 1, fullName: 'Mario Rossi', isWarant: false, number: 3383948838, imageProfileURL: 'https://static.vecteezy.com/ti/vettori-gratis/p3/2158565-avatar-profilo-rosa-neon-icona-muro-mattoni-sfondo-rosa-neon-icona-vettore-vettoriale.jpg'),
      Civ(id: 2, fullName: 'Fabio Neri', isWarant: true, number: 3936295984, imageProfileURL: 'https://static.vecteezy.com/ti/vettori-gratis/p3/2158565-avatar-profilo-rosa-neon-icona-muro-mattoni-sfondo-rosa-neon-icona-vettore-vettoriale.jpg'),
      Civ(id: 3, fullName: 'Jessico Calcetto', isWarant: true, number: 1321564928, imageProfileURL: 'https://static.vecteezy.com/ti/vettori-gratis/p3/2158565-avatar-profilo-rosa-neon-icona-muro-mattoni-sfondo-rosa-neon-icona-vettore-vettoriale.jpg'),
      Civ(id: 4, fullName: 'Mario Rossi', isWarant: false, number: 9878676456, imageProfileURL: 'https://static.vecteezy.com/ti/vettori-gratis/p3/2158565-avatar-profilo-rosa-neon-icona-muro-mattoni-sfondo-rosa-neon-icona-vettore-vettoriale.jpg'),
    ];
  }

  void loadData() {
    listUsers = _myDB.get(tableUsersName);
  }

  void updateDatabase() {
    _myDB.put(tableUsersName, listUsers);
  }
}

class Civ {
  final int id;
  final String fullName;
  final bool isWarant;
  final int number;
  final String imageProfileURL;

  const Civ({
    required this.id,
    required this.fullName,
    required this.isWarant,
    required this.number,
    required this.imageProfileURL,
  });
}
