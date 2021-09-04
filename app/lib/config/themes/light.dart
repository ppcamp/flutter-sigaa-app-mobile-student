import 'package:flutter/material.dart';

lightTheme() => ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.light,
      primaryColor: Colors.black,
      // accentColor: Colors.purple[900],
      accentColor: Color.fromRGBO(62, 64, 149, 1.0),
      backgroundColor: Colors.white10,

      // Define the default font family.
      fontFamily: 'Roboto',

      // Define the default TextTheme. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: const TextTheme(
          // topbar default
          headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          // others
          headline1: TextStyle(fontSize: 30.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0)),

      cardTheme: CardTheme(
        elevation: 2,
      ),
    );
