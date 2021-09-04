import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      required this.icon,
      required this.textfield,
      required this.title,
      required this.error,
      required this.controller,
      required this.maxlength,
      this.shouldObscure = false})
      : super(key: key);

  final String textfield;
  final IconData icon;
  final bool error;
  final bool shouldObscure;
  final String title;
  final int maxlength;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final color = error ? Colors.red : Colors.grey.withOpacity(0.8);
    final mainColor = error ? Colors.red : Colors.grey;
    final iconColor = error ? Colors.red : Theme.of(context).accentColor;

    return Wrap(children: [
      // Title
      Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Text(
          title,
          style:
              TextStyle(color: Theme.of(context).accentColor, fontSize: 16.0),
        ),
      ),

      // Field
      Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Row(
          children: <Widget>[
            // Icon
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: Icon(
                  icon,
                  color: iconColor,
                )),

            // lineborder
            Container(
              height: 30.0,
              width: 1.0,
              color: Colors.grey.withOpacity(0.5),
              margin: const EdgeInsets.only(left: 00.0, right: 10.0),
            ),

            // Input field
            Expanded(
              child: TextFormField(
                style: TextStyle(color: color),
                maxLength: maxlength,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: textfield,
                  counterText: "",
                  hintStyle: TextStyle(color: mainColor),
                ),
                controller: controller,
                obscureText: shouldObscure,
              ),
            )
          ],
        ),
      )
    ]);
  }
}
