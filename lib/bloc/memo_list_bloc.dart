import 'dart:async';

import 'package:filter_memo/model/memo.dart';
import 'package:filter_memo/repository/local_storage_client.dart';
import 'package:filter_memo/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class MemoListBloc {

  MemoRepository _memoRepository = LocalStorageClient();

  BehaviorSubject<List<Memo>> _memoListController = BehaviorSubject();
  Stream<List<Memo>> get memoStream => _memoListController.stream;

  MemoListBloc() {
    var _memoStream = _memoRepository.getMemos().asStream();
    _memoListController.addStream(_memoStream);
  }

  void dispose() {
    _memoListController.close();
  }
}