import 'dart:async';

import 'package:filter_memo/model/memo.dart';
import 'package:filter_memo/network/local_storage_client.dart';
import 'package:filter_memo/network/repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum DataPersistStatus {
  Yet,
  Saving,
  Fail,
}

class CreateMemoPage extends StatefulWidget {
  @override
  _CreateMemoPageState createState() => _CreateMemoPageState();
}

class _CreateMemoPageState extends State<CreateMemoPage> {
  UserPreferencesRepository _userPreferencesRepository = LocalStorageClient();

  MemoRepository _memoRepository = LocalStorageClient();

  Memo _memo;

  final StreamController<DataPersistStatus> _dataPersistStatusStreamController =
      StreamController<DataPersistStatus>();

  @override
  void initState() {
    super.initState();

    _userPreferencesRepository.getFeatures().then((features) {
      if (features != null)
        _memo.features = features;
      else if (_memo == null)
        _memo = Memo([], null, null);
      else
        _memo.features = [];
    });
  }

  @override
  void dispose() {
    super.dispose();
    _dataPersistStatusStreamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("メモを作成"),
      ),
      body: StreamBuilder<DataPersistStatus>(
          stream: _dataPersistStatusStreamController.stream,
          initialData: DataPersistStatus.Yet,
          builder: (context, snapshot) {
            return _bodyWidget(context, snapshot.data);
          }),
    );
  }

  Widget _bodyWidget(BuildContext context, DataPersistStatus status) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        TextField(
          style: TextStyle(fontSize: 20),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          onChanged: (text) {
            if (_memo == null) _memo = Memo(null, null, text);
          },
        ),
        status == DataPersistStatus.Yet
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
                  if (_memo.content != null &&
                      _memo.content.isNotEmpty &&
                      _memo.features != null &&
                      _memo.features.isNotEmpty) {
                    _memo.postDate = DateTime.now();
                    _memoRepository.saveMemo(_memo).then((result) {
                      if (result) Navigator.of(context).pop();
                    });
                  }
                },
              )
            : status == DataPersistStatus.Saving
                ? CircularProgressIndicator()
                : status == DataPersistStatus.Yet ? Container() : null
      ],
    );
  }
}
