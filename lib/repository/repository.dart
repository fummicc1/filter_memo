import '../model/memo.dart';

mixin MemoRepository {
  Future<List<Memo>> getMemos();
  Future<bool> saveMemo(Memo memo);
}