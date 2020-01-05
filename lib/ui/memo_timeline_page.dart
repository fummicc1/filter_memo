import 'package:filter_memo/bloc/memo_timeline_bloc.dart';
import 'package:filter_memo/model/memo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MemoTimelinePage extends StatefulWidget {
  @override
  _MemoTimelinePageState createState() => _MemoTimelinePageState();
}

class _MemoTimelinePageState extends State<MemoTimelinePage> {
  @override
  Widget build(BuildContext context) {
    var myBloc = Provider.of<MemoTimelineBloc>(context);

    myBloc.updateMemoContensSink.add(0);
    myBloc.updateMyFeatureSink.add(0);

    return StreamBuilder<List<String>>(
        stream: myBloc.myFeaturesStream,
        initialData: [],
        builder: (context, myFeatureSnapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text(myFeatureSnapshot.data.isNotEmpty ? myFeatureSnapshot.data.reduce((a, b) => a + " " + b) : ""),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.mode_edit, size: 24,),
                  onPressed: () {
                    Navigator.of(context).pushNamed("/setting_feature_page");
                  },
                )
              ],
            ),
            body: myFeatureSnapshot.data.isEmpty
                ? Center(
                    child: Container(
                      height: 64,
                      child: RaisedButton.icon(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        icon: Icon(Icons.settings),
                        label: Text(
                          "Featureを登録する",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed("/setting_feature_page");
                        },
                      ),
                    ),
                  )
                : StreamBuilder<List<Memo>>(
                    stream: myBloc.displayMemosStream,
                    initialData: [],
                    builder: (context, memosSnapshot) {
                      if (memosSnapshot.data.isEmpty) {
                        return Center(
                          child: Container(
                            height: 64,
                            child: RaisedButton.icon(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              icon: Icon(Icons.create),
                              label: Text(
                                "メモを作成する",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed("/create_memo_page");
                              },
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                          itemCount: memosSnapshot.data.length,
                          itemBuilder: (context, index) {
                            final memo = memosSnapshot.data[index];
                            return ListTile(
                              title: Text(memo.content),
                              subtitle: Text(memo.postDateFormatted),
                            );
                          });
                    },
                  ),
            floatingActionButton: Container(
              width: 80,
              height: 80,
              padding: EdgeInsets.only(right: 32),
              child: FloatingActionButton(
                child: Icon(Icons.create, size: 32,),
                onPressed: () {

                },
              ),
            ),
          );
        });
  }
}
