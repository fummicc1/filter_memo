
import 'package:filter_memo/model/memo.dart';

mixin MemoRepository {
  Future<List<Memo>> getMemos();
}

class APIClient with MemoRepository {

  @override
  Future<List<Memo>> getMemos() {
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

}