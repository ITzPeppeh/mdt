import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:mdt/models/constants.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  static final MyDatabase instance = MyDatabase._init();

  static Database? _database;

  MyDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('db.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final intType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableName (
  ${CivFields.id} $idType,
  ${CivFields.isWarant} $boolType,
  ${CivFields.number} $intType
)
''');
  }

  Future<Civ> create(Civ newcivile) async {
    final db = await instance.database;

    final id = await db.insert(tableName, newcivile.toJson());

    return newcivile.copy(id: id);
  }

  Future<Civ> getCiv(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableName,
      columns: CivFields.values,
      where: '${CivFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Civ.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Civ>> getAllCiv() async {
    final db = await instance.database;
    final result = await db.query(tableName);

    return result.map((json) => Civ.fromJson(json)).toList();
  }

  Future<int> update(Civ civile) async {
    final db = await instance.database;

    return db.update(
      tableName,
      civile.toJson(),
      where: '${CivFields.id} = ?',
      whereArgs: [civile.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableName,
      where: '${CivFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}

// Modello DB
final String tableName = 'civili';

class CivFields {
  static final List<String> values = [id, isWarant, number];

  static final String id = '_id';
  static final String isWarant = 'isWarant';
  static final String number = 'number';
}

class Civ {
  final int? id;
  final bool isWarant;
  final int number;

  const Civ({
    this.id,
    required this.isWarant,
    required this.number,
  });

  Civ copy({
    int? id,
    bool? isWarant,
    int? number,
  }) =>
      Civ(
        id: id ?? this.id,
        isWarant: isWarant ?? this.isWarant,
        number: number ?? this.number,
      );

  static Civ fromJson(Map<String, Object?> json) => Civ(
        id: json[CivFields.id] as int?,
        isWarant: json[CivFields.isWarant] == 1,
        number: json[CivFields.number] as int,
      );

  Map<String, Object?> toJson() => {
        CivFields.id: id,
        CivFields.isWarant: isWarant ? 1 : 0,
        CivFields.number: number,
      };
}
