import 'package:client/globals/localizations.dart';
import 'package:flutter/material.dart';

class InputDialog extends StatefulWidget {
  final String title;
  final String initText;
  final bool emptyEnable;
  final int maxLength;
  final bool obscureText;

  InputDialog({
    @required this.title,
    this.maxLength,
    this.initText = "",
    this.emptyEnable = false,
    this.obscureText = false,
  });

  @override
  createState() => _InputDialog();
}

class _InputDialog extends State<InputDialog> {
  final inputController = TextEditingController();
  String _errorText;

  @override
  void initState() {
    super.initState();
    inputController.text = widget.initText;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: inputController,
        decoration: InputDecoration(errorText: _errorText),
        obscureText: widget.obscureText,
        maxLength: widget.maxLength,
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop()),
        FlatButton(
            onPressed: () {
              if (inputController.text.isEmpty && !widget.emptyEnable) {
                setState(() {
                  _errorText = S.of(context).notNull;
                });
                Future.delayed(Duration(seconds: 2),
                    () => setState(() => _errorText = null));
              } else
                Navigator.of(context).pop(inputController.text);
            },
            child: Icon(Icons.done)),
      ],
    );
  }
}
