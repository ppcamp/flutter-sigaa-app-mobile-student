import 'package:hive/hive.dart';
import 'package:sigaa_student/models/subjects/subjects.dart';
import 'package:sigaa_student/models/systemurls/systemurls.dart';

// firstRun will be the functions that will be called once to configure the
// device
Future<void> firstRun() async {
  //#region: mocking the classes objects
  if (!Hive.isBoxOpen(SystemUrls.boxName)) {
    await Hive.openBox<SystemUrls>(SystemUrls.boxName);
  }
  final urls = Hive.box<SystemUrls>(SystemUrls.boxName);
  if (urls.isEmpty) {
    print("urls is empty. Assigning it");
    urls.addAll([
      SystemUrls(
          url: 'https://sigaa.unifei.edu.br/sigaa/logar.do?dispatch=logOn',
          location: 'login'),
      SystemUrls(
          url:
              'https://sigaa.unifei.edu.br/sigaa/portais/discente/discente.jsf',
          location: 'main'),
      SystemUrls(
          url:
              'https://sigaa.unifei.edu.br/sigaa/geral/estrutura_curricular/busca_geral.jsf',
          location: 'searchresult'),
      SystemUrls(
          url:
              'https://sigaa.unifei.edu.br/sigaa/graduacao/curriculo/lista.jsf',
          location: 'searchlist'),
      SystemUrls(
          url:
              'https://sigaa.unifei.edu.br/sigaa/geral/componente_curricular/busca_geral.jsf',
          location: 'component'),
      SystemUrls(
          url: 'https://sigaa.unifei.edu.br/sigaa/portais/discente/turmas.jsf',
          location: 'subjects'),
    ]);
  }
  urls.close();
  //#endregion

  //#region: mocking the subjects objects
  if (!Hive.isBoxOpen(Subjects.boxName)) {
    await Hive.openBox<Subjects>(Subjects.boxName);
  }
  final subjects = Hive.box<Subjects>(Subjects.boxName);
  if (subjects.isNotEmpty) {
    print("subjects is empty. Assigning it");
    //   subjects.addAll([
    //     Subjects(
    //         acronym: "ECOI20",
    //         place: "Prédio 2 - sala 3",
    //         classname: "GESTÃO DE PROJETOS"),
    //     Subjects(
    //         acronym: "ECOI26",
    //         place: "Prédio 1 - sala 1",
    //         classname: "COMPILADORES"),
    //     Subjects(
    //         acronym: "ECAI05",
    //         place: "Prédio 2 - sala 3",
    //         classname: "LABORATÓRIO DE SISTEMAS DE CONTROLE I"),
    //     Subjects(
    //         acronym: "ECOI24",
    //         place: "Prédio 2 - sala 3",
    //         classname: "COMPUTAÇÃO GRÁFICA E PROCESSAMENTO DIGITAL DE IMAGENS")
    //   ]);
    subjects.deleteFromDisk();
    subjects.clear();
  }
  subjects.close();
  //#endregion
}
