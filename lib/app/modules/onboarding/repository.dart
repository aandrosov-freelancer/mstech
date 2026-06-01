import 'package:get/get.dart';
import '../../data/provider/storage_provider.dart';

class OnboardingRepository {
  final StorageProvider _storageProvider = Get.find<StorageProvider>();

  bool getOnboardingStatus() {
    return _storageProvider.hasSeenOnboarding;
  }

  Future<bool> completeOnboarding() {
    return _storageProvider.setHasSeenOnboarding(true);
  }
}
