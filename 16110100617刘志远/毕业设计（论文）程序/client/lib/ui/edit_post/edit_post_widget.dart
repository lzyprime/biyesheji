import 'package:client/datas/post_data.dart';
import 'package:client/globals/route.dart';
import 'package:client/ui/edit_post/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:client/globals/localizations.dart';
import 'package:provider/provider.dart';

class EditPostWidget extends StatefulWidget {
  final EditPostViewModel viewModel;

  EditPostWidget(PostData data) : viewModel = EditPostViewModel(postData: data);

  @override
  createState() => _EditPostWidgetState();
}

class _EditPostWidgetState extends State<EditPostWidget> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.viewModel.postData.title;
    _contentController.text = widget.viewModel.postData.content;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: widget.viewModel,
        child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              FlatButton(
                  child: Center(child: Text(S.of(context).preview)),
                  textColor: Colors.white,
                  onPressed: widget.viewModel.done
                      ? () => Navigator.of(context).pushNamed(R.previewPost,
                          arguments: widget.viewModel.postData)
                      : null),
              IconButton(
                icon: Icon(Icons.done,
                    color:
                    widget.viewModel.done ? Theme.of(context).accentColor : null),
                onPressed:
                widget.viewModel.done ? () => widget.viewModel.editPost(context) : null,
              )
            ],
          ),
          body: Column(
            children: <Widget>[
              TextField(
                controller: _titleController,
                onChanged: (v) => setState(() => widget.viewModel.postData.title = v),
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
                      setState(() => widget.viewModel.postData.content = v),
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
