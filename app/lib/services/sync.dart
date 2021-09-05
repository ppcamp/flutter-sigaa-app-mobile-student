// Sync with sigaa

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sigaa_student/components/avatar/avatar.dart';
import 'package:sigaa_student/config/setup/globals.dart';
import 'package:sigaa_student/models/login/login.dart';
import 'package:sigaa_student/services/network/scrappers.dart';
import 'package:sigaa_student/utils/images.dart';

class SyncService {
  SyncService() {
    system = ScrappersService()..setup();
  }

  /// The module that will connect and retrieve the system's informations
  late ScrappersService system;

  /// This method will try to [login] using the [payload] credentials, if some
  /// error occurred will return false (failure).
  /// This method will try to login into SIGAA system, get some infos and store
  /// the logo image locally.
  Future<bool> login(LoginPayload payload) async {
    print("trying to login");
    try {
      await system.doLogin(payload);

      // get user image and store it locally
      final avatar = await system.getUserAvatar();
      await saveAvatar(avatar);
      payload.imagePath = await getImagePath();
      userAvatar = getLogoWidget(img: MemoryImage(Uint8List.fromList(avatar)));

      // update hive object
      await Hive.openBox<LoginPayload>(LoginPayload.boxName);
      final box = Hive.box<LoginPayload>(LoginPayload.boxName);

      if (box.isEmpty) {
        await box.add(payload);
      } else {
        await box.putAt(0, payload);
      }

      await box.close();

      return true;
    } catch (err) {
      return false;
    }
  }
}
