import 'package:flutter/material.dart';
import 'package:sigaa_student/components/scaffold/scaffold.dart';

class Grid extends StatelessWidget {
  static const id = "Screen_to_show_specific_class_info";

  const Grid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getScaffold(
      title: 'Grades curriculares',
      context: context,
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            width: 220.0,
            height: 200.0,
            decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/uc-20.gif')))),
        // CircleAvatar(backgroundImage: ,minRadius: 16,),
        Container(
            padding: EdgeInsets.all(16.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Text("Página em construção!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0)),
                Padding(
                    padding: EdgeInsets.all(15.6),
                    child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            style:
                                TextStyle(color: Theme.of(context).hintColor),
                            children: [
                              TextSpan(
                                  text:
                                      "Nesta página o estudante poderá visualizar a grade curricular de qualquer curso."),
                              TextSpan(
                                  text:
                                      " Além disso, cada matéria será 'expandível' (para que ele tenha mais informações sobre ela)."),
                              TextSpan(
                                  text:
                                      " Por fim, as matérias irão ter indicadores coloridos que irão ser baseados no impacto que esta matéria irá ter com base nos pre e co requisitos.",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ])))
              ],
            ))
      ])),
    );
  }
}
