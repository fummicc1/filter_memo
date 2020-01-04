import 'dart:convert';

import 'package:filter_memo/model/memo.dart';
import 'package:filter_memo/network/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageClient with UserPreferencesRepository, MemoRepository {

  @override
  Future<bool> saveFeatures() async {
    final shared = await SharedPreferences.getInstance();
    final result = await shared.setBool("setup_features", true);
    return result;
  }

  Future<bool> checkIsSetupFeatures() async {
    final shared = await SharedPreferences.getInstance();
    final result = shared.getBool("setup_features");
    return result;
  }

  @override
  Future<List<String>> getFeatures() async {
    final shared = await SharedPreferences.getInstance();
    final features = shared.getStringList("setup_features");
    return Future.value(features);
  }

  @override
  Future<List<Memo>> getMemos() async {

    final shared = await SharedPreferences.getInstance();

    final memosJsonData = shared.get("private_memo_list");

    if (memosJsonData == null) return Future.value([]);

    final List<dynamic> memosMap = json.decode(memosJsonData)["values"] as List<dynamic>;;

    List<Memo> memos = [];

    for (int i = 0; i < memosMap.length; i++) {
      final Memo memo = Memo.fromJson(memos[i] as Map<String, dynamic>);
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

    return shared.setString("private_memo_list", jsonData);
  }
}

class LocalStorageClientMock with UserPreferencesRepository, MemoRepository {

  @override
  Future<bool> saveFeatures() {
    return Future<bool>.delayed(Duration(milliseconds: 1), () => true);
  }

  Future<bool> checkIsSetupFeatures() {
    return Future<bool>.delayed(Duration(milliseconds: 1), () => true);
  }

  @override
  Future<List<String>> getFeatures() {
    throw UnimplementedError();
  }

  @override
  Future<List<Memo>> getMemos() async {
    return Future<List<Memo>>.delayed(Duration(milliseconds: 1), () => []);
  }

  @override
  Future<bool> saveMemo(Memo memo) async {
    return Future<bool>.delayed(Duration(milliseconds: 1), () => true);
  }
}