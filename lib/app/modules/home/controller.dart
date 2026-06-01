import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'repository.dart';

class HomeController extends GetxController {
  final HomeRepository repository;

  HomeController({required this.repository});

  Future<void> resetOnboarding() async {
    await repository.resetOnboarding();
    Get.snackbar(
      'Успех'.tr,
      'home_onboarding_reset_success'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1E1E1E),
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
    );
  }
}
