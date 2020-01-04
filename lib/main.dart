import 'package:filter_memo/bloc/memo_timeline_bloc.dart';
import 'package:filter_memo/bloc/setting_feature_bloc.dart';
import 'package:filter_memo/repository/local_storage_client.dart';
import 'package:filter_memo/repository/repository.dart';
import 'package:filter_memo/ui/create_memo_page.dart';
import 'package:filter_memo/ui/memo_timeline_page.dart';
import 'package:filter_memo/ui/settting_feature_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  UserPreferencesRepository _userPreferencesRepository = LocalStorageClientMock();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
        future: _userPreferencesRepository.checkIsSetupFeatures(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Scaffold(body: CircularProgressIndicator());

          if (snapshot.data) return Provider<MemoTimelineBloc>(
            create: (_) => MemoTimelineBloc(),
            dispose: (_, bloc) => bloc.dispose,
            child: MemoTimelinePage(),
          );
          else return Provider<SettingFeatureBloc>(
            create: (_) => SettingFeatureBloc(),
            dispose: (_, bloc) => bloc.dispose,
            child: SettingFeaturePage(),
          );
        },
      ),
      routes: {
        "/memo_timeline_page": (BuildContext context) => Provider<MemoTimelineBloc>(
          create: (_) => MemoTimelineBloc(),
          dispose: (_, bloc) => bloc.dispose,
          child: MemoTimelinePage(),
        ),
        "/create_memo_page": (BuildContext context) => CreateMemoPage(),
        "/setting_feature_page": (BuildContext context) => Provider<SettingFeatureBloc>(
          create: (_) => SettingFeatureBloc(),
          dispose: (_, bloc) => bloc.dispose,
          child: SettingFeaturePage(),
        ),
      },
    );
  }
}