import 'package:client/globals/cache.dart';
import 'package:flutter/material.dart';

import 'package:client/globals/route.dart';
import 'package:client/datas/user_data.dart';

class UserListCard extends StatelessWidget {
  final UserData userData;

  UserListCard(this.userData);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle, border: Border.all(width: 0.5)),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: userData.avatar.isNotEmpty
                ? NetworkImage(userData.avatar)
                : null,
            child: userData.avatar.isEmpty ? FlutterLogo() : null,
          ),
        ),
        title: Text(userData.username),
        subtitle: Text(userData.sexStr),
        trailing: Text(userData.email),
        onTap: () => userData.id != Cache().userData?.id
            ? Navigator.of(context).pushNamed(R.user, arguments: userData)
            : null,
      ),
    );
  }
}
