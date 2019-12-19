import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:client/globals/i18n.dart';
import 'package:client/view_models/auth_view_model.dart';
import 'package:client/views/auth_widgets/submit_button.dart';
import 'package:client/views/auth_widgets/username_field.dart';

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);
    return SingleChildScrollView(
      child: Card(
        elevation: 8,
        margin: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                child: Column(children: <Widget>[
                  /// username input text field
                  UserNameField(),

                  /// password input text field
                  _PassWordField(),
                ]),
                padding: EdgeInsets.all(20)),

            /// error type
            Text(viewModel.loginError ?? '', style: TextStyle(color: Colors.red)),

            /// login button
            Padding(child: SubmitButton(SubmitButtonType.login), padding: EdgeInsets.only(bottom: 20)),
          ],
        ),
      ),
    );
  }
}

class _PassWordField extends StatefulWidget {
  @override
  createState() => _PassWordFieldState();
}

class _PassWordFieldState extends State<_PassWordField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        labelText: S.of(context).password,
        suffix: GestureDetector(
            onTap: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            child: showPassword
                ? Icon(Icons.visibility, color: Theme.of(context).primaryColor)
                : Icon(Icons.visibility_off)),
        errorText: viewModel.passwordError,
      ),
      keyboardType: TextInputType.visiblePassword,
      controller: viewModel.passwordController,
      obscureText: !showPassword,
    );
  }
}
