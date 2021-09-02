import 'package:hive/hive.dart';
import 'package:sigaa_student/models/subjects/subjects.dart';

class Boxes {
  static Box<Subjects> getSubjects() => Hive.box<Subjects>(Subjects.boxName);


}

/// HiveIds typing
/// 0: FirstRun,
/// 1: Subjects,
/// 2: SystemUrls