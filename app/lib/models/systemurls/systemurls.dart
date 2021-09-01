import 'package:hive/hive.dart';

part "systemurls.g.dart";

@HiveType(typeId: 0)
class SystemUrls extends HiveObject {
  static const boxName = 'subjectsBox';

  SystemUrls({required this.url, required this.location});

  @HiveField(0)
  String url; // https://sigaa.unifei.edu.br/sigaa/logar.do?dispatch=logOn

  @HiveField(1)
  String location; // Login
}
