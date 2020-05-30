import 'package:sqflite/sqlite_api.dart';

import './kontak.dart';
import '../db/database_helper.dart';

class CRUD {
  static const todoTable = 'contact';
  static const id = 'id';
  static const name = 'name';
  static const phone = 'phone';
  AccessDatabase dbHelper = new AccessDatabase();
  Future<int> insert(Kontak todo) async {
    Database db = await dbHelper.initDb();
    final sql = '''INSERT INTO ${CRUD.todoTable}
    (
      ${CRUD.name},
      ${CRUD.phone}
    )
    VALUES (?,?)''';
    List<dynamic> params = [todo.name, todo.phone];
    final result = await db.rawInsert(sql, params);
    return result;
  }

  Future<int> delete(Kontak todo) async {
    Database db = await dbHelper.initDb();
    final sql = '''DELETE FROM ${CRUD.todoTable}
    WHERE ${CRUD.id} = ?
    ''';
    List<dynamic> params = [todo.id];
    final result = await db.rawDelete(sql, params);
    return result;
  }

  Future<List<Kontak>> getContactList() async {
    Database db = await dbHelper.initDb();
    final sql = '''SELECT * FROM ${CRUD.todoTable}''';
    final data = await db.rawQuery(sql);
    List<Kontak> todos = List();
    for (final node in data) {
      final todo = Kontak.fromMap(node);
      todos.add(todo);
    }
    return todos;
  }

  Future<int> update(Kontak todo) async {
    Database db = await dbHelper.initDb();
    int count = await db
        .update('contact', todo.toMap(), where: 'id=?', whereArgs: [todo.id]);
    return count;
  }

}
