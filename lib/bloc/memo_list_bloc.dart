import 'dart:async';

import 'package:filter_memo/model/memo.dart';
import 'package:filter_memo/repository/local_storage_client.dart';
import 'package:filter_memo/repository/repository.dart';

class MemoListBloc {

  MemoRepository _memoRepository = LocalStorageClient();

  MemoListBloc() {
    getMemo();
  }

  List<Memo> getMemo() {
     _memoRepository.getMemos();
  }

  void dispose() {
  }
}