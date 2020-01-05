import 'package:filter_memo/bloc/create_memo_bloc.dart';
import 'package:filter_memo/bloc/memo_timeline_bloc.dart';
import 'package:filter_memo/bloc/setting_feature_bloc.dart';

class AppBloc {

  CreateMemoBloc createMemoBloc;
  MemoTimelineBloc memoTimelineBloc;
  SettingFeatureBloc settingFeatureBloc;

  CreateMemoBloc getNewCreateMemoBloc() {
    if (this.createMemoBloc != null) return this.createMemoBloc;
    this.createMemoBloc = CreateMemoBloc();
    return createMemoBloc;
  }
  MemoTimelineBloc getNewMemoTimelineBloc() {
    if (this.memoTimelineBloc != null) return this.memoTimelineBloc;
    this.memoTimelineBloc = MemoTimelineBloc();
    return memoTimelineBloc;
  }
  SettingFeatureBloc getNewSettingFeatureBloc() {
    if (this.settingFeatureBloc != null) return this.settingFeatureBloc;
    this.settingFeatureBloc = SettingFeatureBloc();
    return settingFeatureBloc;
  }

  void dispose() {
    settingFeatureBloc.dispose();
    memoTimelineBloc.dispose();
    createMemoBloc.dispose();
  }

  void disposeCreateMemoBloc() {
    createMemoBloc.dispose();
    createMemoBloc = null;
  }
}