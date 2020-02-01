import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class EditUserInfoWidget extends StatelessWidget {
  static const routeName = "EditUserInfoWidget";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Icon(Icons.edit)),
      body: Center(),
    );
  }
}