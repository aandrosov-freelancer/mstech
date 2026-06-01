import 'package:get/get.dart';
import 'controller.dart';
import 'repository.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeRepository>(() => HomeRepository());
    Get.lazyPut<HomeController>(
      () => HomeController(repository: Get.find<HomeRepository>()),
    );
  }
}
