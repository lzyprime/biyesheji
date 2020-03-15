import 'package:flutter/material.dart';

import 'package:client/ui/user/settings/view_model.dart';
import 'package:provider/provider.dart';

class SettingsWidget extends StatelessWidget {
  final viewModel = SettingsViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Icon(Icons.settings),
          centerTitle: true,
        ),
        body: Consumer<SettingsViewModel>(
          builder: (context, viewModel, __) => ListView(
            children: <Widget>[
              ListTile(
                  title: Text(viewModel.userdata.username),
                  onTap: () => viewModel.editUsername(context)),
              Divider(height: 4, thickness: 2),
              ListTile(
                title: Text(viewModel.userdata.sexStr),
                onTap: () => viewModel.newSex(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
