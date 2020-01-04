import 'package:filter_memo/model/memo.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class MemoTimelinePage extends StatelessWidget {

  final BehaviorSubject<List<Memo>> _memoListSubject = BehaviorSubject.seeded([]);
  Stream<List<Memo>> get memoListStream => _memoListSubject.stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("タイムライン"),
      ),
      body: StreamBuilder<List<Memo>>(
        stream: memoListStream,
        builder: (context, snapShot) {
          return ListView.builder(itemCount: snapShot.data.length, itemBuilder: (context, index) {
            Text("a");
          });
        },
      ),
    );
  }
}
