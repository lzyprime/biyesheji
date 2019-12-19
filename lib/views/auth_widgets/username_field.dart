import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:client/globals/i18n.dart';
import 'package:client/view_models/auth_view_model.dart';

class UserNameField extends StatelessWidget {
  @override
  build(context) {
    final viewModel = Provider.of<AuthViewModel>(context);
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        labelText: S.of(context).username,
        errorText: viewModel.usernameError,
      ),
      controller: viewModel.usernameController,
    );
  }
}
