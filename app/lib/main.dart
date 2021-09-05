import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sigaa_student/config/setup/globals.dart';
import 'package:sigaa_student/config/setup/on_startup.dart';
import 'package:sigaa_student/config/themes/config.dart';
import 'package:sigaa_student/models/setup/setup.dart';
import 'package:sigaa_student/models/subjects/subjects.dart';
import 'package:sigaa_student/models/system_urls/system_urls.dart';
import 'package:sigaa_student/views/dashboard.dart';
import 'package:sigaa_student/views/login.dart';

import 'config/routes/router.dart';
import 'config/routes/routes.dart';
import 'models/login/login.dart';

void main() async {
  // initialize the global variables
  init();

  // main startup routines
  WidgetsFlutterBinding.ensureInitialized(); // guarantees some methods on init
  await Hive.initFlutter(); // setup paths and another things
  Hive // Setting up the adapters (needed to handle with data stored locally)
    ..registerAdapter(SetupAdapter())
    ..registerAdapter(SubjectsAdapter())
    ..registerAdapter(SystemUrlsAdapter())
    ..registerAdapter(LoginPayloadAdapter());

  // setup basic methods
  await onStartup();

  // Setting app the router
  final route = AppRouter(
      routes: AppRoutes.routes,
      notFoundHandler: AppRoutes.routeNotFoundHandler);
  route.setupRoutes();

  // run the flutter app
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SIGAA student",
      theme: getTheme(),
      home: userIsLogged ? DashboardScreen() : LoginScreen(),
    );
  }
}
