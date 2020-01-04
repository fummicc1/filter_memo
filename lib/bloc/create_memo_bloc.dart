import 'package:filter_memo/model/memo.dart';
import 'package:filter_memo/repository/local_storage_client.dart';
import 'package:filter_memo/repository/repository.dart';
import 'package:filter_memo/ui/create_memo_page.dart';
import 'package:rxdart/rxdart.dart';

class CreateMemoBloc {
  final MemoRepository _memoRepository = LocalStorageClient();
  final UserPreferencesRepository _userPreferencesRepository =
      LocalStorageClient();

  final BehaviorSubject<String> _inputtedTextSubject = BehaviorSubject();
  Sink<String> get inputtedTextSink => _inputtedTextSubject.sink;

  final BehaviorSubject<DataPersistStatus> _dataPersistStatusSubject =
      BehaviorSubject();
  Stream<DataPersistStatus> get dataPersistStatusStream =>
      _dataPersistStatusSubject.stream;

  final BehaviorSubject<void> _tappedSaveButtonSubject = BehaviorSubject();
  Sink<void> get tappedSaveButtonSink => _tappedSaveButtonSubject.sink;

  Memo _memo = Memo(null, null, null);

  CreateMemoBloc() {
    _userPreferencesRepository.getFeatures().then((features) {
      this._memo.features = features;
    });

    _inputtedTextSubject.stream.listen((text) {
      this._memo.content = text;

      if (text.isNotEmpty)
        _dataPersistStatusSubject.add(DataPersistStatus.Ready);
    });

    _tappedSaveButtonSubject.stream.listen((_) {
      _memo.postDate = DateTime.now();
      _dataPersistStatusSubject.add(DataPersistStatus.Saving);

      _memoRepository.saveMemo(_memo).then((isSuccess) {
        if (isSuccess)
          _dataPersistStatusSubject.add(DataPersistStatus.Succeed);
        else
          _dataPersistStatusSubject.add(DataPersistStatus.Fail);
      });
    });
  }

  void dispose() {
    _inputtedTextSubject.close();
    _dataPersistStatusSubject.close();
    _tappedSaveButtonSubject.close();
  }
}
