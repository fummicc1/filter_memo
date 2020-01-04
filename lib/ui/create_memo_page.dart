import 'package:filter_memo/model/memo.dart';
import 'package:filter_memo/repository/local_storage_client.dart';
import 'package:filter_memo/repository/repository.dart';
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

  final BehaviorSubject<Memo> _memoSubject = BehaviorSubject();
  final BehaviorSubject<List<String>> _myFeaturesSubject = BehaviorSubject();

  final BehaviorSubject<DataPersistStatus> _dataPersistStatusSubject =
      BehaviorSubject<DataPersistStatus>();

  @override
  void initState() {
    super.initState();

    var features = _userPreferencesRepository.getFeatures().asStream();

    _myFeaturesSubject.addStream(features);
  }

  @override
  void dispose() {
    super.dispose();
    _dataPersistStatusSubject.close();
    _memoSubject.close();
    _myFeaturesSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("メモを作成"),
        ),
        body: StreamBuilder<List<String>>(
          stream: _myFeaturesSubject.stream,
          initialData: [],
          builder: (context, myFeatureSnapshot) {
            return StreamBuilder<Memo>(
              stream: _memoSubject.stream,
              initialData: Memo(null, null, null),
              builder: (context, memoListSnapshot) {
                return StreamBuilder<DataPersistStatus>(
                    stream: _dataPersistStatusSubject.stream,
                    initialData: DataPersistStatus.Yet,
                    builder: (context, statusSnapshot) {
                      return _bodyWidget(context, statusSnapshot.data,
                          memoListSnapshot.data, myFeatureSnapshot.data);
                    });
              },
            );
          },
        ));
  }

  Widget _bodyWidget(BuildContext context, DataPersistStatus status, Memo memo,
      List<String> myFeatures) {
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
            memo.content = text;
            _memoSubject.add(memo);
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
                  if (memo.content != null && memo.content.isNotEmpty) {
                    memo.features = myFeatures;
                    memo.postDate = DateTime.now();
                    _memoRepository.saveMemo(memo).then((result) {
                      if (result)
                        Navigator.of(context).pop();
                      else
                        _dataPersistStatusSubject.add(DataPersistStatus.Fail);
                    });
                  }
                },
              )
            : status == DataPersistStatus.Saving
                ? CircularProgressIndicator()
                : status == DataPersistStatus.Fail ? Container() : null
      ],
    );
  }
}
