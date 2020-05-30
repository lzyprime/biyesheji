import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:client/datas/user_data.dart';
import 'package:client/globals/localizations.dart';
import 'package:client/ui/login/register/view_model.dart';

class RegisterWidget extends StatefulWidget {
  final viewModel = RegisterViewModel();

  @override
  createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.viewModel,
      child: Consumer<RegisterViewModel>(
        builder: (context, viewModel, __) => Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).register),
            centerTitle: true,
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: <Widget>[
                InkWell(
                  onTap: () => viewModel.setAvatar(context),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Theme.of(context).primaryColor),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: viewModel.avatar == null
                          ? Text(S.of(context).avatar)
                          : null,
                      backgroundImage: viewModel.avatar != null
                          ? NetworkImage(viewModel.avatar)
                          : null,
                    ),
                  ),
                ),
                TextField(
                  decoration:
                      InputDecoration(labelText: S.of(context).username),
                  onChanged: (v) => setState(() => viewModel.username = v),
                ),
                TextField(
                  decoration:
                      InputDecoration(labelText: S.of(context).password),
                  onChanged: (v) => setState(() => viewModel.password = v),
                  obscureText: !showPassword,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: S.of(context).rePassword,
                      suffix: InkWell(
                        child: showPassword
                            ? Icon(Icons.visibility,
                                color: Theme.of(context).primaryColor)
                            : Icon(Icons.visibility_off),
                        onTap: () =>
                            setState(() => showPassword = !showPassword),
                      )),
                  onChanged: (v) => setState(() => viewModel.rePassword = v),
                  obscureText: !showPassword,
                ),
                TextField(
                  decoration: InputDecoration(labelText: S.of(context).email),
                  onChanged: (v) => setState(() => viewModel.email = v),
                  keyboardType: TextInputType.emailAddress,
                ),
                ButtonBar(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Radio(
                          value: EnumSex.obscure,
                          groupValue: viewModel.sex,
                          onChanged: (v) => setState(() => viewModel.sex = v)),
                      Text(S.of(context).obscure),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio(
                          value: EnumSex.male,
                          groupValue: viewModel.sex,
                          onChanged: (v) => setState(() => viewModel.sex = v)),
                      Text(S.of(context).male),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio(
                          value: EnumSex.female,
                          groupValue: viewModel.sex,
                          onChanged: (v) => setState(() => viewModel.sex = v)),
                      Text(S.of(context).female),
                    ],
                  ),
                ]),
                Text(viewModel.errorText,
                    style: TextStyle(color: Theme.of(context).accentColor)),
                RaisedButton(
                  child: viewModel.loading
                      ? CircularProgressIndicator()
                      : Text(S.of(context).register),
                  onPressed: (viewModel.allDone && !viewModel.loading)
                      ? () => viewModel.register(context)
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
