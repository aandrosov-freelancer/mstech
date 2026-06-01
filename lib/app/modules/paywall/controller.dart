import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/enums/subscription_type.dart';
import '../../data/services/subscription_service.dart';
import 'repository.dart';

class PaywallController extends GetxController {
  final PaywallRepository repository;

  PaywallController({required this.repository});

  // Access the global SubscriptionService
  final _subscriptionService = Get.find<SubscriptionService>();

  // Track the selected plan using the SubscriptionPlan enum (default to year)
  final selectedPlan = SubscriptionPlan.year.obs;

  // Track the purchasing emulation state
  final isPurchasing = false.obs;

  void selectPlan(SubscriptionPlan plan) {
    if (isPurchasing.value) return;
    selectedPlan.value = plan;
  }

  Future<void> purchaseSubscription() async {
    if (isPurchasing.value) return;

    isPurchasing.value = true;

    try {
      // Delegate core business logic to the SubscriptionService
      await _subscriptionService.purchaseSubscription(selectedPlan.value);

      isPurchasing.value = false;

      // Return back to the previous screen (Home)
      Get.back();

      // Show gorgeous success feedback on the Home screen
      Get.snackbar(
        'subpscription_success'.tr,
        'paywall_purchase_success'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF1E1E1E),
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
        margin: const EdgeInsets.all(16),
        borderRadius: 16,
        borderWidth: 1.5,
        borderColor: const Color(0xFFFFC72C).withValues(alpha: 0.5),
      );
    } catch (e) {
      isPurchasing.value = false;
      Get.snackbar(
        'subcsription_error'.tr,
        'paywall_purchase_error'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF1E1E1E),
        colorText: Colors.white,
      );
    }
  }
}
