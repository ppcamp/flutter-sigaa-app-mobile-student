import 'package:hive/hive.dart';

part "subjects.g.dart";

@HiveType(typeId: 1)
class Subjects extends HiveObject {
  static const boxName = 'subjectsBox';

  Subjects(
      {required this.place,
      required this.classname,
      required this.hour,
      this.period,
      this.acronym,
      this.updatedAt,
      this.url});

  @HiveField(0)
  String place; // sala 3 - anexo a

  @HiveField(1)
  String classname; // Gestão de projetos

  @HiveField(2)
  String hour; // 35M23 OR 5T34

  @HiveField(3)
  String? acronym; // ECOI20

  @HiveField(4)
  String? period; // 2021.1

  @HiveField(5)
  DateTime? updatedAt; // DateTime.now();

  @HiveField(6)
  String?
      url; // url payload like {'form_acessarTurmaVirtual:j_id_jsp_512348736_352':'form_acessarTurmaVirtual:j_id_jsp_512348736_352','frontEndIdTurma':'08D2A045F369838D1E8082A783C8148F20CB0148'}

  /// TODO criar função para converter as horas em horas válidas que serão
  /// exibidas para o usuário nas matérias do dia
}
