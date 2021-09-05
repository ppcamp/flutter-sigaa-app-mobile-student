import 'package:hive/hive.dart';

part "setup.g.dart";

@HiveType(typeId: 0)
class Setup extends HiveObject {
  static const boxName = 'firstrunBox';

  Setup({required this.currentVersion});

  @HiveField(0)
  bool isConfigured = true;

  @HiveField(1)
  String currentVersion = "0.0.1-beta";

  @HiveField(2)
  bool isDarkTheme = false;
}
