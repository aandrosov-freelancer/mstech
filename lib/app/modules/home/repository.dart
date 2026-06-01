import 'package:get/get.dart';
import '../../data/provider/storage_provider.dart';

class HomeRepository {
  final StorageProvider _storageProvider = Get.find<StorageProvider>();

  Future<bool> resetOnboarding() {
    return _storageProvider.setHasSeenOnboarding(false);
  }
}
