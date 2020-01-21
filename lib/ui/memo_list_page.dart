import 'package:filter_memo/bloc/memo_list_bloc.dart';
import 'package:filter_memo/model/memo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MemoListPage extends StatefulWidget {
  @override
  _MemoListPageState createState() => _MemoListPageState();
}

class _MemoListPageState extends State<MemoListPage> {
  @override
  Widget build(BuildContext context) {
    MemoListBloc bloc = Provider.of<MemoListBloc>(context);

    final memoList = bloc.getMemo();

    return Scaffold(
      body: SafeArea(
          child: ListView.builder(
        itemBuilder: (context, index) {
          return Material(
            child: Card(
              child: ListTile(
                title: Text(memoList[index].content),
              ),
            ),
          );
        },
      )),
      floatingActionButton: Container(
        padding: EdgeInsets.only(right: 24, bottom: 32),
        child: FloatingActionButton(
          child: Icon(Icons.create),
          onPressed: () {
            Navigator.of(context).pushNamed("/create_memo");
          },
        ),
      ),
    );
  }
}
