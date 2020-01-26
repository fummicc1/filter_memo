
import 'package:filter_memo/model/memo.dart';
import 'package:filter_memo/repository/local_storage_client.dart';
import 'package:filter_memo/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

enum CreateMemoStatus {
  Uploading,
  Still,
  Success,
  Fail,  
}

class CreateMemoBloc {

  MemoRepository _memoRepository = LocalStorageClient();
  BehaviorSubject<String> _memoSubject = BehaviorSubject();
  String get _memoText => _memoSubject.value;
  Sink<String> get memoSink => _memoSubject.sink;

  BehaviorSubject<void> _saveButtonController = BehaviorSubject();
  Sink<void> get saveButtonSink => _saveButtonController.sink;
  BehaviorSubject<CreateMemoStatus> _status = BehaviorSubject();
  Stream<CreateMemoStatus> get statusStream => _status.stream;


  CreateMemoBloc() {
    _saveButtonController.listen((_) {
      if (_validate(_memoText)) {
        _status.add(CreateMemoStatus.Uploading);
        Memo memo = Memo(_memoText);
        _memoRepository.saveMemo(memo).then((isSuccess) {
          if (isSuccess) {
            _status.add(CreateMemoStatus.Success);
          } else {
            _status.add(CreateMemoStatus.Fail);
          }
        });
      }
    });
  }

  bool _validate(String memo) {
    if (memo.isEmpty) return false;
    return true;
  }

  void dispose() {
    _memoSubject.close();
    _saveButtonController.close();
    _status.close();
  }
}