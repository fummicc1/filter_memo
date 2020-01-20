import 'package:filter_memo/bloc/create_memo_bloc.dart';
import 'package:filter_memo/bloc/memo_list_bloc.dart';
import 'package:filter_memo/ui/create_memo_page.dart';
import 'package:filter_memo/ui/memo_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Memo",
      home: Provider<MemoListBloc>(
        create: (_) => MemoListBloc(),
        dispose: (_, bloc) => bloc.dispose(),
        child: MemoListPage(),
      ),
      routes: {
        "/create_memo": (context) => Provider<CreateMemoBloc>(
          child: CreateMemoPage(),
          create: (_) => CreateMemoBloc(),
          dispose: (_, bloc) => bloc.dispose(),
        ),
      },
    );
  }
}
