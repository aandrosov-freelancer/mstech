import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageProvider extends GetxService {
  late final SharedPreferences _prefs;

  Future<StorageProvider> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  static const String _onboardingKey = 'has_seen_onboarding';
  static const String _subscriptionTypeKey = 'subscription_type';
  static const String _subscriptionTimestampKey = 'subscription_timestamp';

  bool get hasSeenOnboarding => _prefs.getBool(_onboardingKey) ?? false;

  Future<bool> setHasSeenOnboarding(bool value) async {
    return await _prefs.setBool(_onboardingKey, value);
  }

  String get subscriptionType =>
      _prefs.getString(_subscriptionTypeKey) ?? 'none';

  Future<bool> setSubscriptionType(String value) async {
    return await _prefs.setString(_subscriptionTypeKey, value);
  }

  int get subscriptionTimestamp =>
      _prefs.getInt(_subscriptionTimestampKey) ?? 0;

  Future<bool> setSubscriptionTimestamp(int value) async {
    return await _prefs.setInt(_subscriptionTimestampKey, value);
  }

  Future<void> clearSubscription() async {
    await _prefs.remove(_subscriptionTypeKey);
    await _prefs.remove(_subscriptionTimestampKey);
  }
}
