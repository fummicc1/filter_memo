import '../model/memo.dart';

mixin UserPreferencesRepository {
  Future<bool> saveFeatures();
  Future<bool> checkIsSetupFeatures();
  Future<List<String>> getFeatures();
}

mixin MemoRepository {
  Future<List<Memo>> getMemos();
  Future<bool> saveMemo(Memo memo);
}