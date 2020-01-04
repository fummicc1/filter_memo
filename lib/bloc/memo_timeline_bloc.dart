import 'package:filter_memo/model/memo.dart';
import 'package:filter_memo/repository/local_storage_client.dart';
import 'package:filter_memo/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class MemoTimelineBloc {

  final MemoRepository _memoRepository = LocalStorageClient();
  final UserPreferencesRepository _userPreferencesRepository = LocalStorageClient();

  final BehaviorSubject<List<String>> _myFeaturesSubject = BehaviorSubject.seeded([]);
  Stream<List<String>> get myFeaturesStream => _myFeaturesSubject.stream;

  final BehaviorSubject<List<Memo>> _displayMemosSubject = BehaviorSubject();
  Stream<List<Memo>> get displayMemosStream => _displayMemosSubject.stream;

  MemoTimelineBloc() {

     var myFeatures = _userPreferencesRepository.getFeatures().asStream();

     _myFeaturesSubject.addStream(myFeatures);

     _myFeaturesSubject.stream.listen((myFeatures) {

       List<Memo> filterMemos = [];

       var displayMemos = _displayMemosSubject.value;
       var number = 0;

       for (int i = 0; i < displayMemos.length; i++) {
         if (displayMemos[i].features.contains(myFeatures[0])) {
           number++;
         }
         if (displayMemos[i].features.contains(myFeatures[1])) {
           number++;
         }
         if (displayMemos[i].features.contains(myFeatures[2])) {
           number++;
         }

         if (number >= 2) {
           filterMemos.add(displayMemos[i]);
         }
         number = 0;
       }

       _displayMemosSubject.add(filterMemos);
     });

     var displayMemos = _memoRepository.getMemos().asStream();
     _displayMemosSubject.addStream(displayMemos);
  }

  void dispose() {
    _myFeaturesSubject.close();
    _displayMemosSubject.close();
  }

}