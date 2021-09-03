import 'package:flutter/material.dart';
import 'package:sigaa_student/components/scaffold/app_bar.dart';
import 'package:sigaa_student/components/scaffold/menu_drawer.dart';

/*
 * It returns the main page configuration (with side menu and title)
 * Usually used by almost every pages
 */
getScaffold({
  required BuildContext context,
  required Widget body,
  required String title,
}) {
  return Scaffold(
      body: body,
      appBar: getAppBar(context, title),
      drawer: getAppDrawer(context));
}
