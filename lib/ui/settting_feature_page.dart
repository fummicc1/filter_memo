import 'dart:async';
import 'package:filter_memo/model/memo.dart';
import 'package:filter_memo/network/local_storage_client.dart';
import 'package:filter_memo/network/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SettingFeaturePage extends StatelessWidget {
  final BehaviorSubject<List<int>> _selectedIndexListController =
      BehaviorSubject.seeded([]);

  final UserPreferencesRepository _userPreferencesRepository = LocalStorageClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Featureを設定"),
      ),
      body: StreamBuilder<List<int>>(
          stream: _selectedIndexListController.stream,
          builder: (context, snapshot) {
            return Padding(
              padding:
                  const EdgeInsets.only(top: 40, bottom: 40, left: 8, right: 8),
              child: GridView.count(
                  scrollDirection: Axis.horizontal,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 16,
                  crossAxisCount: 4,
                  children: _createGridViewContent(context, snapshot.data)),
            );
          }),
    );
  }

  List<Container> _createGridViewContent(
      BuildContext context, List<int> selectedList) {
    return featureList.map((feature) {
      return Container(
        decoration: BoxDecoration(
            color: selectedList.isEmpty
                ? Colors.white
                : selectedList.map((i) => featureList[i]).contains(feature)
                    ? Colors.lightGreen
                    : Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(24)),
        child: SizedBox.expand(
            child: FlatButton(
          child: Text(feature),
          onPressed: () {
            final int index = featureList.indexOf(feature);
            final currentValue = _selectedIndexListController.value;

            if (currentValue.contains(index))
              currentValue.remove(index);
            else
              currentValue.add(index);

            _selectedIndexListController
                .add(_selectedIndexListController.value);

            if (currentValue.length == 3) {
              _userPreferencesRepository.saveFeatures().then((result) {
                if (result)
                  Navigator.of(context).pushNamed("/memo_timeline_page");
              });
            }
          },
        )),
      );
    }).toList();
  }
}
