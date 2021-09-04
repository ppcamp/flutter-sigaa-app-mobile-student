import 'package:hive/hive.dart';

part "firstrun.g.dart";

@HiveType(typeId: 0)
class FirstRun extends HiveObject {
  static const boxName = 'firstrunBox';

  @HiveField(0)
  bool isConfigured = true;
}
