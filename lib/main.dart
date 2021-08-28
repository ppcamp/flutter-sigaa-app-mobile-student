import 'package:flutter/material.dart';
import 'package:sigaa_student/config/base.dart';
import 'package:sigaa_student/config/routes/routes.dart';
import 'package:sigaa_student/config/themes/config.dart';
import 'package:sigaa_student/views/Dashboard/dashboard.dto.dart';
import 'package:sigaa_student/repository/student_class.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final store = StudentClassStore();
  await store.init();
  final items = await store.getAll();

  if (items.isEmpty) {
    await store.create(StudentClassDTO(
        acronym: "ECOI20",
        place: "Prédio 2 - sala 3",
        classname: "GESTÃO DE PROJETOS"));
    await store.create(StudentClassDTO(
        acronym: "ECOI26",
        place: "Prédio 1 - sala 1",
        classname: "COMPILADORES"));

    await store.create(StudentClassDTO(
        acronym: "ECAI05",
        place: "Prédio 2 - sala 3",
        classname: "LABORATÓRIO DE SISTEMAS DE CONTROLE I"));
    await store.create(StudentClassDTO(
        acronym: "ECOI24",
        place: "Prédio 2 - sala 3",
        classname: "COMPUTAÇÃO GRÁFICA E PROCESSAMENTO DIGITAL DE IMAGENS"));
  }

  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildApp(
      appName: "SIGAA student",
      theme: getTheme(),
      routes: getRoutes(),
    );
  }
}
