import 'base_store.dart';

class StudentClassStore extends Store {
  init() {
    return super.initialize(
      "CREATE TABLE student_class (id INTEGER PRIMARY KEY, acronym TEXT, classname TEXT, place TEXT");
  }
}