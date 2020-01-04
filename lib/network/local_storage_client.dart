import 'package:shared_preferences/shared_preferences.dart';

mixin UserPreferencesRepository {
  Future<bool> saveFeatures();
  Future<bool> checkIsSetupFeatures();
}

class LocalStorageClient with UserPreferencesRepository {

  @override
  Future<bool> saveFeatures() async {
    final shared = await SharedPreferences.getInstance();
    final result = await shared.setBool("setup_features", true);
    return result;
  }

  Future<bool> checkIsSetupFeatures() async {
    final shared = await SharedPreferences.getInstance();
    final result = await shared.getBool("setup_features");
    return result;
  }
}

class LocalStorageClientMock with UserPreferencesRepository {

  @override
  Future<bool> saveFeatures() {
    return Future<bool>.delayed(Duration(milliseconds: 1), () => true);
  }

  Future<bool> checkIsSetupFeatures() {
    return Future<bool>.delayed(Duration(milliseconds: 1), () => true);
  }

}