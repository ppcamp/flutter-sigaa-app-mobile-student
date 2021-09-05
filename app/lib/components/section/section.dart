import 'package:flutter/material.dart';

class SectionWidget extends StatelessWidget {
  const SectionWidget({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 16.0)),
        Padding(padding: EdgeInsets.all(15.6), child: body)
      ],
    );
  }
}
