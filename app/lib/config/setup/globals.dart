// initialize the stores
import 'package:flutter/material.dart';
import 'package:sigaa_student/components/avatar/avatar.dart';

/// the app current version (for control only)
const String AppVersion = 'v0.0.1-beta';

/// the image file that will be used
late Widget userAvatar;

/// variable that will be the responsable to choose the main screen
late bool userIsLogged;

/// initialize all global variables
void init() {
  userIsLogged = false;
  userAvatar = getLogoWidget();
}
