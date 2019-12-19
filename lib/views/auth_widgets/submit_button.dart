import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:client/globals/i18n.dart';
import 'package:client/view_models/auth_view_model.dart';

enum SubmitButtonType { login, register }

class SubmitButton extends StatelessWidget {
  final SubmitButtonType type;

  SubmitButton(this.type);

  @override
  build(context) {
    final viewModel = Provider.of<AuthViewModel>(context);
    AuthStateType state = type == SubmitButtonType.login ? viewModel.loginState : viewModel.registerState;
    final text = type == SubmitButtonType.login ? S.of(context).login : S.of(context).register;

    return CupertinoButton(
      borderRadius: BorderRadius.circular(50),
      padding: EdgeInsets.zero,
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        alignment: Alignment.center,
        height: 50,
        width: state == AuthStateType.normal ? 240 : 60,
        child: state == AuthStateType.loading
            ? ClipOval(child: CircularProgressIndicator(backgroundColor: Colors.white))
            : (state == AuthStateType.done ? Icon(Icons.done, color: Colors.white) : Text(text)),
      ),
      onPressed: state == AuthStateType.normal
          ? () => (type == SubmitButtonType.login ? viewModel.login(context) : viewModel.register(context))
          : null,

      color: Theme.of(context).primaryColor,
      disabledColor: Theme.of(context).primaryColor,
    );
  }
}
