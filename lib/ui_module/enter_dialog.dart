import 'package:flutter/material.dart';

class EnterDialog extends StatelessWidget {
  final title;
  EnterDialog(this.title);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actions: <Widget>[
        FlatButton(onPressed: () => Navigator.of(context).pop(), child: Icon(Icons.close)),
        FlatButton(onPressed: () => Navigator.of(context).pop(true), child: Icon(Icons.done)),
      ],
    );
  }
}