import 'package:get/get.dart';
import '../../data/provider/storage_provider.dart';

class PaywallRepository {
  final StorageProvider _storageProvider = Get.find<StorageProvider>();

  String getSubscriptionType() {
    return _storageProvider.subscriptionType;
  }

  Future<bool> setSubscriptionType(String value) {
    return _storageProvider.setSubscriptionType(value);
  }

  Future<bool> setSubscriptionTimestamp(int value) {
    return _storageProvider.setSubscriptionTimestamp(value);
  }

  Future<void> clearSubscription() {
    return _storageProvider.clearSubscription();
  }
}
