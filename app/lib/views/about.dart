import 'package:flutter/material.dart';
import 'package:sigaa_student/components/scaffold/scaffold.dart';
import 'package:sigaa_student/components/section/section.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getScaffold(
        title: 'Sobre',
        context: context,
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // CircleAvatar(backgroundImage: ,minRadius: 16,),
          Container(
              padding: EdgeInsets.all(16.0),
              child: Wrap(alignment: WrapAlignment.center, children: [
                // objetivo
                SectionWidget(
                    title: "Objetivo",
                    body: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            style:
                                TextStyle(color: Theme.of(context).hintColor),
                            children: [
                              TextSpan(
                                  text:
                                      "Desenvolver um sistema que possa ser utilizado pelos estudantes de universidades que utilizem o SIGAA. O aplicativo terá recursos adicionais, de maneira a complementar a utilização do sistema original."),
                            ]))),

                // desenvolvedores
                SectionWidget(
                    title: 'Desenvolvedor(es)',
                    body: Wrap(
                      children: [
                        InkWell(
                          child: Text(
                            "Pedro A. C. Santos -- @ppcamp",
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                          ),
                          onTap: () => launch("https://github.com/ppcamp"),
                        ),
                      ],
                    )),

                // licença
                SectionWidget(
                    title: 'Licença',
                    body: Wrap(children: [
                      RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                              style:
                                  TextStyle(color: Theme.of(context).hintColor),
                              children: [
                                TextSpan(
                                    text:
                                        "Este aplicativo é distribuído através da "),
                              ])),
                      InkWell(
                        child: Text(
                          "Licença BSD",
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
                        onTap: () => launch(
                            "https://opensource.org/licenses/BSD-3-Clause"),
                      ),
                    ])),
              ]))
        ])));
  }
}
