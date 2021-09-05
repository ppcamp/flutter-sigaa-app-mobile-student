import 'package:flutter/material.dart';

getAppBar(BuildContext context, String title) {
  return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).accentColor),
      ),
      backwardsCompatibility: false,
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      foregroundColor: Theme.of(context).accentColor);
}
