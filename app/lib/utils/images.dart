import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

const AvatarName = "avatar.jpg";

Future<String> getDirPath() async {
  print("getting path");

  Directory appDocumentsDirectory =
      await getApplicationDocumentsDirectory(); // 1
  return appDocumentsDirectory.path;
}

/// getImagePath retrieves the path of the avatar/logo image locally
Future<String> getAvatarPath() async {
  final path = await getDirPath();
  final logopath = "$path/$AvatarName";

  return logopath;
}

/// readLogo will read the image file saved previously by the function
/// [saveAvatar]
Future<Uint8List> getAvatarBytes({String? avatarpath}) async {
  print("reading image");

  try {
    String p = avatarpath ?? await getAvatarPath();
    File file = new File(p);
    final img = file.readAsBytesSync();
    // return Image.memory(img);
    return img;
  } catch (err) {
    rethrow;
  }
}

/// saveLogo will store an image as [data] locally.
/// This image can be later retrieved by using [getAvatarBytes]
Future<void> saveAvatar(List<int> data) async {
  print("saving image");

  try {
    File file = File(await getAvatarPath());
    file.writeAsBytesSync(data);
  } catch (err) {
    rethrow;
  }
}

/// This will delete the avatar image saved previously
Future<void> deleteAvatar() async {
  try {
    final img = await getAvatarPath();
    final file = File(img);
    await file.delete();
  } catch (err) {
    rethrow;
  }
}
