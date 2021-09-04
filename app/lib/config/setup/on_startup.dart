import 'package:hive/hive.dart';
import 'package:sigaa_student/config/setup/first_run.dart';
import 'package:sigaa_student/models/setup/setup.dart';

// onStartup is the function that will check if the app is running for the first
// time in this phone
Future<void> onStartup() async {
  print("statup routine");

  if (!Hive.isBoxOpen(Setup.boxName)) {
    print("openning the box that check if the object is already configured");
    await Hive.openBox<Setup>(Setup.boxName);
  }

  final box = Hive.box<Setup>(Setup.boxName);

  if (box.isEmpty) {
    print("box isn't configured yet. Configuring...");
    await firstRun();
    box.add(Setup());
  }

  box.close();
  print("startup rountine finished");
}
