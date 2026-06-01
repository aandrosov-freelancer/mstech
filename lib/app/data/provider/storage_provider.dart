import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageProvider extends GetxService {
  late final SharedPreferences _prefs;

  Future<StorageProvider> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  static const String _onboardingKey = 'has_seen_onboarding';

  bool get hasSeenOnboarding => _prefs.getBool(_onboardingKey) ?? false;

  Future<bool> setHasSeenOnboarding(bool value) async {
    return await _prefs.setBool(_onboardingKey, value);
  }
}
