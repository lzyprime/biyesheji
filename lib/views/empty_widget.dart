import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("empty widget")),
    body: Center(
      child: Text("empty widget"),
    ),
  );
}