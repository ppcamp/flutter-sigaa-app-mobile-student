import 'package:hive/hive.dart';

part "setup.g.dart";

@HiveType(typeId: 0)
class Setup extends HiveObject {
  static const boxName = 'firstrunBox';

  @HiveField(0)
  bool isConfigured = true;
}
