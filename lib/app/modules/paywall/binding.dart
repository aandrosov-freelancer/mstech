import 'package:get/get.dart';
import 'controller.dart';
import 'repository.dart';

class PaywallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaywallRepository>(() => PaywallRepository());
    Get.lazyPut<PaywallController>(
      () => PaywallController(repository: Get.find<PaywallRepository>()),
    );
  }
}
