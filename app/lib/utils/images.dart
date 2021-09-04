import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

const LogoName = "logo.jpg";

Future<String> getDirPath() async {
  print("getting path");

  Directory appDocumentsDirectory =
      await getApplicationDocumentsDirectory(); // 1
  return appDocumentsDirectory.path;
}

/// getImagePath retrieves the path of the avatar/logo image locally
Future<String> getImagePath() async {
  final path = await getDirPath();
  final logopath = "$path/$LogoName";

  return logopath;
}

/// readLogo will read the image file saved previously by the function
/// [saveLogo]
Future<Image> readLogo() async {
  print("reading image");

  try {
    File file = new File(await getImagePath());
    return Image.memory(file.readAsBytesSync());
  } catch (err) {
    rethrow;
  }
}

/// saveLogo will store an image as [data] locally.
/// This image can be later retrieved by using [readLogo]
Future<void> saveLogo(dynamic data) async {
  print("saving image");

  try {
    File file = File(await getImagePath());
    file.writeAsString(data);
  } catch (err) {
    rethrow;
  }
}
