import 'package:sigaa_student/components/StudentClass/class.dto.dart';
import 'package:sqflite/sqflite.dart';

import 'base.dart';

class StudentClassStore extends Store {
  // We should remove the element if when syncing, it doesn't appear
  final table = 'student_class';

  // initialize a new table if don't exists
  Future init() async {
    return await super.initialize(
        "CREATE TABLE student_class (id INTEGER PRIMARY KEY, acronym TEXT, classname TEXT, place TEXT);");
  }

  // create an element.
  // If the element already exists, replace it.
  // NOTE: this function can be used as update too
  Future<void> create(StudentClassDTO student) async {
    await database.insert(table, student.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // delete a given element basing on its id
  Future<void> delete(int id) async {
    await database.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  // getAll gets all elements in this given table
  Future<List<StudentClassDTO>> getAll({FindQuery? find}) async {
    final List<Map<String, dynamic>> maps =
        await database.query(table, limit: find?.limit, offset: find?.offset);
    return List.generate(
        maps.length,
        (i) => StudentClassDTO(
              acronym: maps[i]['acronym'],
              classname: maps[i]['classname'],
              place: maps[i]['place'],
            ));
  }
}
