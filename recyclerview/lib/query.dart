import 'package:recyclerview/fruit.dart';
import 'dart:async';
import 'package:recyclerview/database_helper.dart';

class QueryCtr {
DatabaseHelper con = new DatabaseHelper();

  Future<List<Fruits>> getAllFruits() async {
    var dbClient = await con.db;
    var res = await dbClient.query("fruits");
    
    List<Fruits> list =
        res.isNotEmpty ? res.map((c) => Fruits.fromMap(c)).toList() : null;

    return list;
  }
}