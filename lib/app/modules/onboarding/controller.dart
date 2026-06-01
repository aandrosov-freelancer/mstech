import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/routes.dart';
import 'repository.dart';

class OnboardingController extends GetxController {
  final OnboardingRepository repository;

  OnboardingController({required this.repository});

  final pageController = PageController();
  final currentPageIndex = 0.obs;

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onPageChanged(int index) {
    currentPageIndex.value = index;
  }

  Future<void> handleContinue() async {
    if (currentPageIndex.value < 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      await repository.completeOnboarding();
      Get.offAllNamed(AppRoutes.home);
    }
  }
}
