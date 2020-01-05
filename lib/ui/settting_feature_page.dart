import 'package:filter_memo/bloc/setting_feature_bloc.dart';
import 'package:filter_memo/model/memo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingFeaturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var myBloc = Provider.of<SettingFeatureBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Featureを設定"),
      ),
      body: StreamBuilder<List<int>>(
          stream: myBloc.selectedIndexListStream,
          initialData: [],
          builder: (context, snapshot) {

            if (snapshot.hasData && snapshot.data.isNotEmpty && snapshot.data.length == 3) {
              return Center(
                child: FlatButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/memo_timeline_page");
                    },
                    icon: Icon(Icons.done),
                    label: Text(
                      "設定完了！",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )),
              );
            }

            return Padding(
              padding:
                  const EdgeInsets.only(top: 40, bottom: 40, left: 8, right: 8),
              child: GridView.count(
                  scrollDirection: Axis.horizontal,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 16,
                  crossAxisCount: 4,
                  children:
                      _createGridViewContent(context, snapshot.data, myBloc)),
            );
          }),
    );
  }

  List<Container> _createGridViewContent(
      BuildContext context, List<int> selectedList, SettingFeatureBloc myBloc) {
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
            myBloc.currentlySelectedIndexSink.add(index);
          },
        )),
      );
    }).toList();
  }
}
