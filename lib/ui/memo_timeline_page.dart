import 'package:filter_memo/model/memo.dart';
import 'package:filter_memo/network/api_client.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class MemoTimelinePage extends StatelessWidget {

  final MemoRepository _memoRepository = APIClientMock();
  Future<List<Memo>> get memosFuture =>_memoRepository.getMemos();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("タイムライン"),
      ),
      body: FutureBuilder<List<Memo>>(
        future: memosFuture,
        builder: (context, snapShot) {
          return ListView.builder(itemCount: snapShot.data.length, itemBuilder: (context, index) {
            final memo = snapShot.data[index];
            return ListTile(
              title: Text(memo.content),
              subtitle: Text(memo.postDate.toString()),
            );
          });
        },
      ),
    );
  }
}
