import 'package:filter_memo/bloc/create_memo_bloc.dart';
import 'package:filter_memo/bloc/memo_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateMemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CreateMemoBloc bloc = Provider.of(context);

    return StreamBuilder<CreateMemoStatus>(
        stream: bloc.statusStream,
        initialData: CreateMemoStatus.Still,
        builder: (context, snapshot) {
          if (snapshot.data == CreateMemoStatus.Uploading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data == CreateMemoStatus.Fail) {
          } else if (snapshot.data == CreateMemoStatus.Success) {
            Navigator.of(context).pop();
          }

          return Scaffold(
            appBar: AppBar(
              title: Text("Create Memo"),
            ),
            body: SafeArea(
                child: Column(
              children: <Widget>[
                TextField(
                  maxLines: 6,
                  minLines: 1,
                  decoration: InputDecoration(
                    hintText: "メモ",
                  ),
                  onChanged: (text) {
                    bloc.memoSink.add(text);
                  },
                ),
                FlatButton.icon(
                  icon: Icon(Icons.save),
                  label: Text("完了"),
                  onPressed: () {
                    bloc.saveButtonSink.add(null);
                  },
                )
              ],
            )),
          );
        });
  }
}
