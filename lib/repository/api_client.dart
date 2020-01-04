import 'package:filter_memo/model/memo.dart';
import 'package:filter_memo/repository/repository.dart';

class APIClient with MemoRepository {

  @override
  Future<List<Memo>> getMemos() {
    throw UnimplementedError();
  }

  @override
  Future<bool> saveMemo(Memo memo) {
    throw UnimplementedError();
  }
}

class APIClientMock with MemoRepository {

  final targets1 = [
    "大学生",
    "プログラミング",
    "野球"
  ];
  final targets2 = [
    "大学生",
    "テニス",
    "サッカー"
  ];
  final targets3 = [
    "パート",
    "水泳",
    "メガネ"
  ];

  @override
  Future<List<Memo>> getMemos() {
    return Future.value([
      Memo(targets1, DateTime.now(), "テスト１"),
      Memo(targets2, DateTime.now(), "テスト2"),
      Memo(targets3, DateTime.now(), "テスト3"),
    ]);
  }

  @override
  Future<bool> saveMemo(Memo memo) {
    return Future.delayed(Duration(milliseconds: 1), () => true);
  }
}