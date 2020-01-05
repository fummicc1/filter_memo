import 'dart:convert';

import 'package:filter_memo/model/memo.dart';
import 'package:filter_memo/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageClient with UserPreferencesRepository, MemoRepository {

  @override
  Future<bool> saveFeatures(List<String> features) async {
    final shared = await SharedPreferences.getInstance();
    final _ = await shared.setBool("setup_features", true);
    final result = await shared.setStringList("features", features);
    return result;
  }

  Future<bool> checkIsSetupFeatures() async {
    final shared = await SharedPreferences.getInstance();

    final keys = shared.getKeys();
    if (!keys.contains("setup_features")) {
      return Future.value(false);
    }
    final _ = shared.getBool("setup_features");
    return true;
  }

  @override
  Future<List<String>> getFeatures() async {
    final shared = await SharedPreferences.getInstance();

    final keys = shared.getKeys();
    if (!keys.contains("features")) {
      return Future.value([]);
    }

    final features = shared.getStringList("features");
    return Future.value(features);
  }

  @override
  Future<List<Memo>> getMemos() async {

    final shared = await SharedPreferences.getInstance();

    final keys = shared.getKeys();
    if (!keys.contains("private_memo_list")) {
      return Future.value([]);
    }

    final memosJsonData = shared.get("private_memo_list");
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

    return shared.setString("private_memo_list", jsonData);
  }
}

class LocalStorageClientMock with UserPreferencesRepository, MemoRepository {

  @override
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

  @override
  Future<bool> saveFeatures(List<String> features) {
    return Future<bool>.delayed(Duration(milliseconds: 1), () => true);
  }
}