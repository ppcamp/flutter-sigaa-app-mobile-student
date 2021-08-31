import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sigaa_student/config/themes/config.dart';
import 'package:sigaa_student/models/login/login.dart';
import 'package:sigaa_student/models/subjects/subjects.dart';
import 'package:sigaa_student/services/network/scrappers.dart';
import 'package:sigaa_student/views/dashboard.dart';

import 'config/routes/router.dart';
import 'config/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Scrappers.doLogin(LoginPayload(login: "12638891665", password: "!iz!Qr9PN6thnh7"));

  final route = AppRouter(
      routes: AppRoutes.routes,
      notFoundHandler: AppRoutes.routeNotFoundHandler);
  route.setupRoutes();

  await Hive.initFlutter();

  // Setting up the adapters (needed to handle with data stored locally)
  Hive..registerAdapter(SubjectsAdapter());

  //#region mocking boxes
  if (!Hive.isBoxOpen(Subjects.boxName)) {
    await Hive.openBox<Subjects>(Subjects.boxName);
  }

  final box = Hive.box<Subjects>(Subjects.boxName);
  if (box.isEmpty) {
    print("Box is empty. Assigning it");
    box.addAll([
      Subjects(
          acronym: "ECOI20",
          place: "Prédio 2 - sala 3",
          classname: "GESTÃO DE PROJETOS"),
      Subjects(
          acronym: "ECOI26",
          place: "Prédio 1 - sala 1",
          classname: "COMPILADORES"),
      Subjects(
          acronym: "ECAI05",
          place: "Prédio 2 - sala 3",
          classname: "LABORATÓRIO DE SISTEMAS DE CONTROLE I"),
      Subjects(
          acronym: "ECOI24",
          place: "Prédio 2 - sala 3",
          classname: "COMPUTAÇÃO GRÁFICA E PROCESSAMENTO DIGITAL DE IMAGENS")
    ]);
  }
  box.close();
  print("Box closed");
  //#endregion

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
