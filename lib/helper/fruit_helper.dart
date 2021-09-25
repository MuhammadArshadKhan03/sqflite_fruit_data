import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_app/model/fruit_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper();

  Database? _database;

  Future<Database> get database async => _database ?? await _initDatabse();

  Future<Database> _initDatabse() async {
    Directory doumentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(doumentsDirectory.path, "fruit.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    return db.execute('''CREATE TABLE fruit(
   id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT
    )''');
  }

  Future<List<Fruit>> getFruit() async {
    Database db = await instance.database;
    var fruit = await db.query("fruit", orderBy: 'name');

    List<Fruit> fruitList =
        fruit.isNotEmpty ? fruit.map((e) => Fruit.fromMap(e)).toList() : [];
    return fruitList;
  }

  Future<int> add(Fruit fruit) async {
    Database db = await instance.database;
    int a = await db.insert('fruit', fruit.toMap());
    return a;
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    int a = await db.delete("fruit", where: "id = ?", whereArgs: [id]);
    return a;
  }

  Future<int> update(Fruit fruit) async {
    Database db = await instance.database;
    int a = await db
        .update("fruit", fruit.toMap(), where: "id = ?", whereArgs: [fruit.id]);
    return a;
  }
}
