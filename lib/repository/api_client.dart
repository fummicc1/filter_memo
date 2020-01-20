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
  @override
  Future<List<Memo>> getMemos() {
    return Future.value([
      Memo(DateTime.now(), "テスト１"),
      Memo(DateTime.now(), "テスト2"),
      Memo(DateTime.now(), "テスト3"),
    ]);
  }

  @override
  Future<bool> saveMemo(Memo memo) {
    return Future.delayed(Duration(milliseconds: 1), () => true);
  }
}