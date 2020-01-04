import 'package:filter_memo/model/memo.dart';
import 'package:filter_memo/network/local_storage_client.dart';
import 'package:filter_memo/network/repository.dart';
import 'package:flutter/material.dart';

class MemoTimelinePage extends StatefulWidget {
  @override
  _MemoTimelinePageState createState() => _MemoTimelinePageState();
}

class _MemoTimelinePageState extends State<MemoTimelinePage> {
  final MemoRepository _memoRepository = LocalStorageClient();
  final UserPreferencesRepository _userPreferencesRepository =
      LocalStorageClient();

  List<String> _myFeatures = [];

  List<Memo> _displayMemos = [];

  @override
  void initState() {
    super.initState();

    _userPreferencesRepository.getFeatures().then((features) {
      if (features != null)
        setState(() {
          _myFeatures = features;
        });

      _memoRepository.getMemos().then((memos) {
        List<Memo> displayMemos = memos.where((memo) {
          return memo.features.contains(_myFeatures[0]) ||
              memo.features.contains(_myFeatures[1]) ||
              memo.features.contains(_myFeatures[2]);
        });

        setState(() {
          _displayMemos = displayMemos;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("タイムライン"),
      ),
      body: _myFeatures.isEmpty
          ? Center(
              child: Container(
                height: 64,
                child: RaisedButton.icon(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  icon: Icon(Icons.settings),
                  label: Text(
                    "Featureを登録する",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed("/setting_feature_page");
                  },
                ),
              ),
            )
          : _displayMemos.isEmpty
              ? Center(
                  child: Container(
                    height: 64,
                    child: RaisedButton.icon(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      icon: Icon(Icons.create),
                      label: Text(
                        "メモを作成する",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed("/create_memo_page");
                      },
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: _displayMemos.length,
                  itemBuilder: (context, index) {
                    final memo = _displayMemos[index];
                    return ListTile(
                      title: Text(memo.content),
                      subtitle: Text(memo.postDate.toString()),
                    );
                  }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 32, right: 24),
        child: FloatingActionButton(
          child: Icon(Icons.add, size: 40),
          onPressed: () {
            if (_myFeatures.isNotEmpty)
              Navigator.of(context).pushNamed("/create_memo_page");
          },
        ),
      ),
    );
  }
}
