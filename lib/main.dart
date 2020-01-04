import 'package:filter_memo/network/local_storage_client.dart';
import 'package:filter_memo/ui/create_memo_page.dart';
import 'package:filter_memo/ui/memo_timeline_page.dart';
import 'package:filter_memo/ui/settting_feature_page.dart';
import 'package:flutter/material.dart';

import 'network/repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  UserPreferencesRepository _userPreferencesRepository = LocalStorageClientMock();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
        future: _userPreferencesRepository.checkIsSetupFeatures(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Scaffold(body: CircularProgressIndicator());

          if (snapshot.data) return MemoTimelinePage();
          else return SettingFeaturePage();
        },
      ),
      routes: {
        "/memo_timeline_page": (BuildContext context) => MemoTimelinePage(),
        "/create_memo_page": (BuildContext context) => CreateMemoPage(),
        "/setting_feature_page": (BuildContext context) => SettingFeaturePage(),
      },
    );
  }
}