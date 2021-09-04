import 'package:flutter/material.dart';
import 'package:sigaa_student/components/scaffold/scaffold.dart';

class Calendar extends StatelessWidget {
  static const id = "Screen_to_show_specific_class_info";

  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getScaffold(
      title: 'Calendário',
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
                                      "Esta página irá ter um calendário onde será possível ver os eventos do dia. "),
                              TextSpan(
                                  text:
                                      "Estes eventos serão baseados em atividades marcadas pelo sistema e "),
                              TextSpan(
                                  text: "possivelmente",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text:
                                      " poderão ter um campo para a inserção manual de algum evento que não esteja no sistema.")
                            ])))
              ],
            ))
      ])),
    );
  }
}
