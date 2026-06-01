import 'package:get/get.dart';
import '../enums/subscription_type.dart';
import '../provider/storage_provider.dart';

class SubscriptionService extends GetxService {
  final StorageProvider _storageProvider = Get.find<StorageProvider>();

  Future<void> purchaseSubscription(SubscriptionPlan plan) async {
    // Business logic: Emulate server request processing
    await Future.delayed(const Duration(milliseconds: 1500));

    // Persist subscription locally
    await _storageProvider.setSubscriptionType(plan.name);
    await _storageProvider.setSubscriptionTimestamp(
      DateTime.now().millisecondsSinceEpoch,
    );
  }
}
