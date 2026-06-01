import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../core/values/colors.dart';
import 'controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        title: Text(
          'home_title'.tr,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.cardBg,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Pizza Icon surrounded by an animated circle
                Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: AppColors.cardBg,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.15),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.check_circle_outline,
                        color: AppColors.primary,
                        size: 90,
                      ),
                    )
                    .animate()
                    .fade(duration: const Duration(milliseconds: 600))
                    .scale(
                      duration: const Duration(milliseconds: 600),
                      begin: const Offset(0.4, 0.4),
                      curve: Curves.elasticOut,
                    ),

                const SizedBox(height: 40),

                // Welcome message
                Text(
                      'home_welcome'.tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w900,
                            fontSize: 24,
                          ),
                    )
                    .animate()
                    .fade(
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 500),
                    )
                    .slideY(begin: 0.3, end: 0),

                const SizedBox(height: 12),

                Text(
                      'home_subtitle'.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 15,
                        height: 1.4,
                      ),
                    )
                    .animate()
                    .fade(
                      delay: const Duration(milliseconds: 400),
                      duration: const Duration(milliseconds: 500),
                    )
                    .slideY(begin: 0.3, end: 0),

                const SizedBox(height: 60),

                // Reset Onboarding Button
                Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: AppColors.textSecondary.withValues(alpha: 0.3),
                          width: 1.5,
                        ),
                      ),
                      child: OutlinedButton.icon(
                        onPressed: controller.resetOnboarding,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textPrimary,
                          side: BorderSide.none,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        icon: const Icon(
                          Icons.refresh,
                          size: 20,
                          color: AppColors.primary,
                        ),
                        label: Text(
                          'home_reset_onboarding'.tr,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                    .animate()
                    .fade(delay: 600.ms, duration: 500.ms)
                    .scale(begin: const Offset(0.9, 0.9)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
