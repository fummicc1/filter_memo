import 'package:filter_memo/model/memo.dart';
import 'package:filter_memo/repository/local_storage_client.dart';
import 'package:filter_memo/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class CreateMemoBloc {

  final UserPreferencesRepository _userPreferencesRepository = LocalStorageClient();

  final BehaviorSubject<List<int>> _selectedIndexListSubject = BehaviorSubject.seeded([]);
  Stream<List<int>> get selectedIndexListStream => _selectedIndexListSubject.stream;

  final BehaviorSubject<int> _currentlySelectedIndexSubject = BehaviorSubject();
  Sink<int> get currentlySelectedIndexSink => _currentlySelectedIndexSubject.sink;

  SettingFeatureBloc() {

    _currentlySelectedIndexSubject.stream.listen((index) {

      final List<int> indexList = _selectedIndexListSubject.value;
      List<int> newList = [];

      if (indexList.contains(index)) {
        indexList.remove(index);
      } else {
        indexList.add(index);
      }

      _selectedIndexListSubject.add(indexList);
    });

    _selectedIndexListSubject.stream.listen((list) {
      if (list.length == 3) {
        var features = list.map((i) => featureList[i]);
        _userPreferencesRepository.saveFeatures(features);
      }
    });

  }

  void dispose() {
    _selectedIndexListSubject.close();
    _currentlySelectedIndexSubject.close();
  }

}