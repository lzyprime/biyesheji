import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:client/globals/i18n.dart';
import 'package:client/view_models/auth_view_model.dart';
import 'package:client/views/auth_widgets/username_field.dart';
import 'package:client/views/auth_widgets/submit_button.dart';

class RegisterWidget extends StatelessWidget {
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
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: <Widget>[
                UserNameField(),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: S.of(context).password,
                    errorText: viewModel.passwordError,
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  controller: viewModel.passwordController,
                  obscureText: true,
                ),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: S.of(context).enterPassword,
                    errorText: viewModel.enterPasswordError,
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  controller: viewModel.enterPasswordController,
                  obscureText: true,
                ),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: S.of(context).email,
                    errorText: viewModel.emailError,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: viewModel.emailController,
                ),

                /// select gender
                ButtonBar(children: <Widget>[
                  Row(children: <Widget>[
                    Radio(value: 1, groupValue: viewModel.gender, onChanged: viewModel.setGender),
                    Text(S.of(context).male)
                  ]),
                  Row(children: <Widget>[
                    Radio(value: 2, groupValue: viewModel.gender, onChanged: viewModel.setGender),
                    Text(S.of(context).female)
                  ]),
                  Row(children: <Widget>[
                    Radio(value: 0, groupValue: viewModel.gender, onChanged: viewModel.setGender),
                    Text(S.of(context).obscure)
                  ])
                ], alignment: MainAxisAlignment.center)
              ],
            ),
          ),
          Text(viewModel.registerError ?? '', style: TextStyle(color: Colors.red)),
          Padding(child: SubmitButton(SubmitButtonType.register), padding: EdgeInsets.only(bottom: 20)),
        ],
      ),
    ));
  }
}
