import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sigaa_student/config/setup/onStartup.dart';
import 'package:sigaa_student/config/themes/config.dart';
import 'package:sigaa_student/models/firstrun/firstrun.dart';
import 'package:sigaa_student/models/login/login.dart';
import 'package:sigaa_student/models/subjects/subjects.dart';
import 'package:sigaa_student/models/systemurls/systemurls.dart';
import 'package:sigaa_student/services/network/scrappers.dart';
import 'package:sigaa_student/views/dashboard.dart';

import 'config/routes/router.dart';
import 'config/routes/routes.dart';

void main() async {
  // main startup routines
  WidgetsFlutterBinding.ensureInitialized(); // guarantees some methods on init
  await Hive.initFlutter(); // setup paths and another things
  Hive // Setting up the adapters (needed to handle with data stored locally)
    ..registerAdapter(FirstRunAdapter())
    ..registerAdapter(SubjectsAdapter())
    ..registerAdapter(SystemUrlsAdapter());

  // setup basic methods
  await onStartup();

  // debugging
  final spyder = Scrappers();
  await spyder.setUrls();
  await spyder.doLogin(LoginPayload(
    login: "12638891665",
    password: "!iz!Qr9PN6thnh7"));

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
      home: DashboardScreen(),
    );
  }
}
