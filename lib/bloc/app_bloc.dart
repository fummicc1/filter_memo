import 'package:filter_memo/bloc/create_memo_bloc.dart';
import 'package:filter_memo/bloc/memo_timeline_bloc.dart';
import 'package:filter_memo/bloc/setting_feature_bloc.dart';

class AppBloc {

  CreateMemoBloc createMemoBloc;
  MemoTimelineBloc memoTimelineBloc;
  SettingFeatureBloc settingFeatureBloc;

  CreateMemoBloc getNewCreateMemoBloc() {
    this.createMemoBloc = CreateMemoBloc();
    return createMemoBloc;
  }
  MemoTimelineBloc getNewMemoTimelineBloc() {
    this.memoTimelineBloc = MemoTimelineBloc();
    return memoTimelineBloc;
  }
  SettingFeatureBloc getNewSettingFeatureBloc() {
    this.settingFeatureBloc = SettingFeatureBloc();
    return settingFeatureBloc;
  }

  void dispose() {
    settingFeatureBloc.dispose();
    memoTimelineBloc.dispose();
    createMemoBloc.dispose();
  }
}