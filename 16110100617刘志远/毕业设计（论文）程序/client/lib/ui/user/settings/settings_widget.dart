import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:client/ui/user/settings/view_model.dart';
import 'package:client/globals/localizations.dart';

class SettingsWidget extends StatelessWidget {
  final viewModel = SettingsViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Icon(Icons.settings),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider.value(
        value: viewModel,
        child: Consumer<SettingsViewModel>(
          builder: (context, viewModel, __) => viewModel.userData == null
              ? systemSettings(context)
              : ListView(
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Card(
                          child: ListTile(
                              title: Text(S.of(context).avatar),
                              trailing: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: (viewModel
                                            .userData?.avatar?.isNotEmpty ??
                                        false)
                                    ? NetworkImage(viewModel.userData.avatar)
                                    : null,
                              ),
                              onTap: () => viewModel.setAvatar(context)),
                        ),
                        Card(
                          child: ListTile(
                              title: Text(S.of(context).username),
                              trailing: Text(viewModel.userData.username),
                              onTap: () => viewModel.editUsername(context)),
                        ),
                        Card(
                          child: ListTile(
                            title: Text(S.of(context).gender),
                            trailing: Text(viewModel.userData.sexStr),
                            onTap: () => viewModel.newSex(context),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: Text(S.of(context).password),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () => viewModel.newPassword(context),
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 50, thickness: 1),
                    systemSettings(context),
                    Divider(height: 50, thickness: 1),
                    Card(
                      child: FlatButton(
                          onPressed: () => viewModel.logout(context),
                          child: Text(S.of(context).logout)),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget systemSettings(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Card(
            child: ListTile(
                title: Text(S.of(context).language),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () => viewModel.language(context)),
          ),
          Card(
            child: ListTile(
                title: Text(S.of(context).theme),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () => viewModel.theme(context)),
          ),
          Card(
            child: ListTile(
                title: Text(S.of(context).darkTheme),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () => viewModel.darkTheme(context)),
          ),
        ],
      );
}
