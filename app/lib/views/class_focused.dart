import 'package:flutter/material.dart';
import 'package:sigaa_student/components/scaffold/scaffold.dart';

class ClassFocused extends StatelessWidget {
  const ClassFocused({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getScaffold(
      title: 'Matéria qualquer',
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
                                      "Esta página irá ter informações como: aulas e tópicos, participantes e chat. "),
                              TextSpan(
                                  text: "Futuramente ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text:
                                      "também irá ter suporte à exibição das notas, notícias e frequência"),
                            ])))
              ],
            ))
      ])),
    );
  }
}
