import 'package:client/globals/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:client/globals/localizations.dart';
import 'package:client/view_models/login_view_model.dart';

class LoginWidget extends StatefulWidget {
  @override
  createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => LoginViewModel(),
        child: Scaffold(
          appBar: AppBar(title: Text("${S.of(context).login}")),
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Consumer<LoginViewModel>(
              builder: (_, viewModel, __) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20),
                  TextField(
                    onChanged: (v) =>
                        setState(() => viewModel.username = v),
                    decoration: InputDecoration(
                        labelText:
                            "${S.of(context).username}/${S.of(context).email}"),
                  ),
                  TextField(
                    onChanged: (v) =>
                        setState(() => viewModel.password = v),
                    decoration: InputDecoration(
                      labelText: S.of(context).password,
                      suffix: InkWell(
                        child: showPassword
                            ? Icon(Icons.visibility,
                                color: Theme.of(context).primaryColor)
                            : Icon(Icons.visibility_off),
                        onTap: () =>
                            setState(() => showPassword = !showPassword),
                      ),
                    ),
                    obscureText: !showPassword,
                  ),
                  SizedBox(
                    height: 20,
                    child: Text(viewModel.errorText ?? "",
                        style: TextStyle(
                            color: Theme.of(context).accentColor)),
                  ),
                  RaisedButton(
                    onPressed: viewModel.enableLogin && !viewModel.loading
                        ? () => viewModel.login(context)
                        : null,
                    child: viewModel.loading
                        ? CircularProgressIndicator()
                        : Text(S.of(context).login),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: FlatButton(
                        onPressed: () {},
                        child: Text(S.of(context).register),
                        textColor: Theme.of(context).accentColor),
                  ),
                ],
              ),
            ),
          ),
          extendBodyBehindAppBar: true,
        ),
      );
}
