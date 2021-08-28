import 'package:hive/hive.dart';

part "subjects.g.dart";

@HiveType(typeId: 0)
class Subjects extends HiveObject {
  static const boxName = 'subjectsBox';

  Subjects(
      {required this.acronym, required this.place, required this.classname});

  @HiveField(0)
  String? id; // class local id

  @HiveField(1)
  String acronym; // ECOI20

  @HiveField(2)
  String place; // sala 3 - anexo a

  @HiveField(3)
  String classname; // Gestão de projetos
}
