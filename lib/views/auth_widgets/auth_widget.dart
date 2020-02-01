import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:client/globals/i18n.dart';
import 'package:client/datas/user_data.dart';
import 'package:client/view_models/auth_view_model.dart';

class AuthWidget extends StatelessWidget {
  static const routeName = 'AuthWidget';

  static final routeBuilder = (_) => ChangeNotifierProvider(
        create: (context) => AuthViewModel(context),
        child: AuthWidget(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("${S.of(context).login}/${S.of(context).register}")),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: Provider.of<AuthViewModel>(context).isRegister
            ? buildRegisterColumn(context)
            : buildLoginColumn(context),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
    );
  }

  Column buildLoginColumn(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 80,
          alignment: Alignment.centerRight,
          child: FlatButton(
            onPressed: viewModel.changeRegister,
            child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Text(S.of(context).register),
              Icon(Icons.arrow_forward)
            ]),
          ),
        ),
        TextField(
          controller: viewModel.usernameController,
          decoration: InputDecoration(labelText: S.of(context).username),
        ),
        TextField(
          controller: viewModel.passwordController,
          decoration: InputDecoration(
            labelText: S.of(context).password,
            suffix: InkWell(
              child: viewModel.showPassword
                  ? Icon(Icons.visibility,
                      color: Theme.of(context).primaryColor)
                  : Icon(Icons.visibility_off),
              onTap: viewModel.changeShowPassword,
            ),
          ),
          obscureText: !viewModel.showPassword,
        ),
        SizedBox(
          height: 20,
          child: Text(viewModel.errorText ?? "",
              style: TextStyle(color: Theme.of(context).accentColor)),
        ),
        RaisedButton(
          onPressed: viewModel.loading ? null : viewModel.login,
          child: Text(S.of(context).login),
        )
      ],
    );
  }

  Column buildRegisterColumn(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 80,
          alignment: Alignment.centerLeft,
          child: FlatButton(
            onPressed: viewModel.changeRegister,
            child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Icon(Icons.arrow_back),
              Text(S.of(context).login)
            ]),
          ),
        ),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Theme.of(context).accentColor),
          ),
          child: CircleAvatar(
              radius: 50,
              child: FlutterLogo(size: 50),
              backgroundColor: Colors.transparent,
          ),
        ),
        TextField(
          controller: viewModel.usernameController,
          decoration: InputDecoration(labelText: S.of(context).username),
        ),
        TextField(
          controller: viewModel.passwordController,
          decoration: InputDecoration(
              labelText: S.of(context).password,
              suffix: InkWell(
                child: viewModel.showPassword
                    ? Icon(Icons.visibility,
                        color: Theme.of(context).primaryColor)
                    : Icon(Icons.visibility_off),
                onTap: viewModel.changeShowPassword,
              )),
          obscureText: !viewModel.showPassword,
        ),
        TextField(
          controller: viewModel.rePasswordController,
          decoration: InputDecoration(
            labelText: S.of(context).rePassword,
            suffix: InkWell(
              child: viewModel.showPassword
                  ? Icon(Icons.visibility,
                      color: Theme.of(context).primaryColor)
                  : Icon(Icons.visibility_off),
              onTap: viewModel.changeShowPassword,
            ),
          ),
          obscureText: !viewModel.showPassword,
        ),
        TextField(
          controller: viewModel.emailController,
          decoration: InputDecoration(labelText: S.of(context).email),
        ),
        ButtonBar(
          children: <Widget>[
            Radio(
                value: EnumSex.male,
                groupValue: viewModel.sex,
                onChanged: viewModel.setSex),
            Text(S.of(context).male),
            Radio(
                value: EnumSex.female,
                groupValue: viewModel.sex,
                onChanged: viewModel.setSex),
            Text(S.of(context).female),
            Radio(
                value: EnumSex.obscure,
                groupValue: viewModel.sex,
                onChanged: viewModel.setSex),
            Text(S.of(context).obscure),
          ],
        ),
        SizedBox(
          height: 20,
          child: Text(viewModel.errorText ?? "",
              style: TextStyle(color: Theme.of(context).accentColor)),
        ),
        RaisedButton(
          onPressed: viewModel.loading ? null : viewModel.register,
          child: Text(S.of(context).register),
        )
      ],
    );
  }
}
