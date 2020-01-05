import 'package:filter_memo/bloc/app_bloc.dart';
import 'package:filter_memo/bloc/create_memo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum DataPersistStatus {
  Yet,
  Ready,
  Saving,
  Succeed,
  Fail,
}

class CreateMemoPage extends StatefulWidget {
  @override
  _CreateMemoPageState createState() => _CreateMemoPageState();
}

class _CreateMemoPageState extends State<CreateMemoPage> {
  @override
  Widget build(BuildContext context) {
    final appBloc = Provider.of<AppBloc>(context);
    final bloc = Provider.of<CreateMemoBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("メモを作成"),
      ),
      body: StreamBuilder<DataPersistStatus>(
          stream: bloc.dataPersistStatusStream,
          initialData: DataPersistStatus.Yet,
          builder: (context, statusSnapshot) {
            return _bodyWidget(context, statusSnapshot.data, bloc, appBloc);
          }),
    );
  }

  Widget _bodyWidget(BuildContext context, DataPersistStatus status,
      CreateMemoBloc bloc, AppBloc appBloc) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        status == DataPersistStatus.Yet
            ? Center(child: Text("メモを入力してみましょう！"))
            : Container(),
        TextField(
          style: TextStyle(fontSize: 20),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          onChanged: (text) {
            bloc.inputtedTextSink.add(text);
          },
        ),
        SizedBox.fromSize(
          size: Size.fromHeight(40),
        ),
        status == DataPersistStatus.Ready
            ? FlatButton.icon(
                icon: Icon(
                  Icons.save,
                  size: 24,
                ),
                label: Text(
                  "保存",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                onPressed: () {
                  bloc.tappedSaveButtonSink.add(null);
                },
              )
            : status == DataPersistStatus.Saving
                ? CircularProgressIndicator()
                : status == DataPersistStatus.Fail
                    ? Container()
                    : status == DataPersistStatus.Succeed
                        ? Container(
                            height: 64,
                            width: 96,
                            margin: EdgeInsets.all(32),
                            child: RaisedButton.icon(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              label: Text(
                                "完了！",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 32),
                              ),
                              icon: Icon(
                                Icons.done,
                                size: 40,
                              ),
                            ),
                          )
                        : Container(),
      ],
    );
  }
}
