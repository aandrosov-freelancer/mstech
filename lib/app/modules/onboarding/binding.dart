import 'package:get/get.dart';
import 'controller.dart';
import 'repository.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingRepository>(() => OnboardingRepository());
    Get.lazyPut<OnboardingController>(
      () => OnboardingController(repository: Get.find<OnboardingRepository>()),
    );
  }
}
