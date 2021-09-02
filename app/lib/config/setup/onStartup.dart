import 'package:hive/hive.dart';
import 'package:sigaa_student/config/setup/firstRun.dart';
import 'package:sigaa_student/models/firstrun/firstrun.dart';

// onStartup is the function that will check if the app is running for the first
// time in this phone
Future<void> onStartup() async {
  print("statup routine");

  if (!Hive.isBoxOpen(FirstRun.boxName)) {
    print("openning the box that check if the object is already configured");
    await Hive.openBox<FirstRun>(FirstRun.boxName);
  }

  final box = Hive.box<FirstRun>(FirstRun.boxName);

  if (box.isEmpty) {
    print("box isn't configured yet. Configuring...");
    final run = FirstRun();
    await firstRun();
    box
      ..add(run)
      ..close();
  }
}
