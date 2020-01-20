import 'dart:convert';

import 'package:filter_memo/model/memo.dart';
import 'package:filter_memo/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageClient with MemoRepository {

  @override
  Future<List<Memo>> getMemos() async {

    final shared = await SharedPreferences.getInstance();

    final keys = shared.getKeys();
    if (!keys.contains("memo_list")) {
      return Future.value([]);
    }

    final memosJsonData = shared.get("memo_list");
    if (memosJsonData == null) return Future.value([]);

    final List<dynamic> memosMap = json.decode(memosJsonData)["values"] as List<dynamic>;

    List<Memo> memos = [];

    for (int i = 0; i < memosMap.length; i++) {
      final Memo memo = Memo.fromJson(memosMap[i] as Map<String, dynamic>);
      memos.add(memo);
    }

    return memos;
  }

  @override
  Future<bool> saveMemo(Memo memo) async {
    final shared = await SharedPreferences.getInstance();
    final memos = await getMemos();
    memos.add(memo);
    String jsonData = json.encode({ "values": memos });
    return shared.setString("memo_list", jsonData);
  }
}

class LocalStorageClientMock with MemoRepository {

  @override
  Future<List<Memo>> getMemos() async {
    return Future<List<Memo>>.delayed(Duration(milliseconds: 1), () => []);
  }

  @override
  Future<bool> saveMemo(Memo memo) async {
    return Future<bool>.delayed(Duration(milliseconds: 1), () => true);
  }
}