import 'package:client/datas/post_data.dart';
import 'package:client/globals/route.dart';
import 'package:client/view_models/edit_post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:client/globals/localizations.dart';
import 'package:provider/provider.dart';

class EditPostWidget extends StatefulWidget {
  final EditPostViewModel _viewModel;

  EditPostWidget(this._viewModel);

  @override
  createState() => _EditPostWidgetState(_viewModel);
}

class _EditPostWidgetState extends State<EditPostWidget> {
  final EditPostViewModel _viewModel;
  final TextEditingController _titleController, _contentController;

  _EditPostWidgetState(EditPostViewModel viewModel)
      : _viewModel = viewModel,
        _titleController =
            TextEditingController(text: viewModel.postData.title),
        _contentController =
            TextEditingController(text: viewModel.postData.content);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: _viewModel,
        child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              FlatButton(
                  child: Center(child: Text(S.of(context).preview)),
                  textColor: Colors.white,
                  onPressed: _viewModel.done
                      ? () => Navigator.of(context).pushNamed(R.previewPost,
                          arguments: _viewModel.postData)
                      : null),
              IconButton(
                icon: Icon(Icons.done,
                    color:
                        _viewModel.done ? Theme.of(context).accentColor : null),
                onPressed:
                    _viewModel.done ? () => _viewModel.editPost(context) : null,
              )
            ],
          ),
          body: Column(
            children: <Widget>[
              TextField(
                controller: _titleController,
                onChanged: (v) => setState(() => _viewModel.postData.title = v),
                decoration: InputDecoration.collapsed(
                  hintText: S.of(context).postTitle,
                ),
                style: Theme.of(context).textTheme.headline,
              ),
              Divider(color: Colors.black),
              Expanded(
                child: TextField(
                  controller: _contentController,
                  onChanged: (v) =>
                      setState(() => _viewModel.postData.content = v),
                  decoration: InputDecoration.collapsed(
                      hintText: S.of(context).postContent),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
              )
            ],
          ),
        ));
  }
}
