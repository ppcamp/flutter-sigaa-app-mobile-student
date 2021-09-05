import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sigaa_student/components/avatar/avatar.dart';
import 'package:sigaa_student/config/setup/first_run.dart';
import 'package:sigaa_student/config/setup/globals.dart';
import 'package:sigaa_student/models/login/login.dart';
import 'package:sigaa_student/models/setup/setup.dart';
import 'package:sigaa_student/utils/images.dart';

// onStartup is the function that will check if the app is running for the first
// time in this phone
Future<void> onStartup() async {
  print("statup routine");

  // open the setup box
  if (!Hive.isBoxOpen(Setup.boxName)) {
    print("openning the box that check if the object is already configured");
    await Hive.openBox<Setup>(Setup.boxName);
  }
  final box = Hive.box<Setup>(Setup.boxName);
  if (box.isEmpty) {
    print("box isn't configured yet. Configuring...");
    await firstRun();
    box.add(Setup(currentVersion: AppVersion));
  }
  box.close();

  // checking if the user already logged into sigaa's system
  if (!Hive.isBoxOpen(LoginPayload.boxName)) {
    print("openning the user box");
    await Hive.openBox<LoginPayload>(LoginPayload.boxName);
  }
  final userbox = Hive.box<LoginPayload>(LoginPayload.boxName);
  if (userbox.isNotEmpty) {
    print("user is not empty");
    userIsLogged = true;
    final user = userbox.values.first;
    final imgbytes = await getAvatarBytes(avatarpath: user.imagePath);
    final img = MemoryImage(imgbytes);
    print("updating the image widget");
    userAvatar = getLogoWidget(img: img);
  }
  userbox.close();

  print("startup rountine finished");
}
