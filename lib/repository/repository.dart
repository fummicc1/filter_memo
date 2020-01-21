import '../model/memo.dart';

mixin MemoRepository {
  List<Memo> getMemos();
  Future<bool> saveMemo(Memo memo);
}