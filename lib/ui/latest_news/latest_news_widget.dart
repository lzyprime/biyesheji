import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:client/globals/localizations.dart';
import 'package:client/ui_module/post_list_card.dart';
import 'package:client/ui/latest_news/view_model.dart';

class LatestNewsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LatestNewsViewModel viewModel = Provider.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).news),
        ),
        body: RefreshIndicator(
            child: ListView.builder(
                itemBuilder: (_, i) => PostListCard(viewModel.data[i]),
                itemCount: viewModel.data.length),
            onRefresh: viewModel.refresh),
    );
  }
}
