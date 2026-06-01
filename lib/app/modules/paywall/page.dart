import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../core/values/colors.dart';
import '../../data/enums/subscription_type.dart';
import 'controller.dart';

class PaywallPage extends GetView<PaywallController> {
  const PaywallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Stack(
        children: [
          // 1. Premium Aesthetic Background with Glowing Orbs
          Positioned(
            top: -100,
            right: -50,
            child:
                Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withValues(alpha: 0.15),
                      ),
                    )
                    .animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    )
                    .scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.2, 1.2),
                      duration: const Duration(seconds: 4),
                      curve: Curves.easeInOut,
                    ),
          ),
          Positioned(
            top: 250,
            left: -100,
            child:
                Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.accent.withValues(alpha: 0.08),
                      ),
                    )
                    .animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    )
                    .scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.3, 1.3),
                      duration: const Duration(seconds: 5),
                      curve: Curves.easeInOut,
                    ),
          ),

          // 2. Main Scrollable Content
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Top Header actions (e.g. back button)
                SliverToBoxAdapter(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                      child: CircleAvatar(
                        backgroundColor: AppColors.cardBg,
                        radius: 20,
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 18,
                          ),
                          onPressed: () => Get.back(),
                        ),
                      ),
                    ),
                  ),
                ),

                // Main promotional header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 12),
                        // Golden Animated Pizza Crown Logo
                        Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: AppColors.cardBg,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.accent.withValues(
                                    alpha: 0.4,
                                  ),
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.accent.withValues(
                                      alpha: 0.15,
                                    ),
                                    blurRadius: 20,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.workspace_premium,
                                color: AppColors.accent,
                                size: 50,
                              ),
                            )
                            .animate()
                            .fade(duration: 500.ms)
                            .scale(
                              begin: const Offset(0.6, 0.6),
                              curve: Curves.elasticOut,
                              duration: 800.ms,
                            ),

                        const SizedBox(height: 24),

                        // Title
                        Text(
                              'paywall_title'.tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            )
                            .animate()
                            .fade(delay: 150.ms, duration: 400.ms)
                            .slideY(
                              begin: 0.2,
                              end: 0,
                              curve: Curves.easeOutQuad,
                            ),

                        const SizedBox(height: 8),

                        // Subtitle
                        Text(
                              'paywall_subtitle'.tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                                height: 1.4,
                              ),
                            )
                            .animate()
                            .fade(delay: 300.ms, duration: 400.ms)
                            .slideY(
                              begin: 0.2,
                              end: 0,
                              curve: Curves.easeOutQuad,
                            ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),

                // Subscription Cards List
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // Monthly Subscription Card
                      _buildSubscriptionCard(
                        context: context,
                        type: SubscriptionPlan.month,
                        title: 'paywall_monthly_title'.tr,
                        subtitle: 'paywall_monthly_desc'.tr,
                        price: 'paywall_monthly_price'.tr,
                        benefits: [
                          'paywall_benefit_free_pizza'.tr,
                          'paywall_benefit_fast_delivery'.tr,
                        ],
                        badgeText: null,
                        isPremiumAccent: false,
                        delayMs: 400,
                      ),

                      const SizedBox(height: 24),

                      // Annual Subscription Card (Highlighted / Premium Accent)
                      _buildSubscriptionCard(
                        context: context,
                        type: SubscriptionPlan.year,
                        title: 'paywall_annual_title'.tr,
                        subtitle: 'paywall_annual_desc'.tr,
                        price: 'paywall_annual_price'.tr,
                        benefits: [
                          'paywall_benefit_free_pizza'.tr,
                          'paywall_benefit_fast_delivery'.tr,
                          'paywall_benefit_exclusive_recipes'.tr,
                        ],
                        badgeText: 'paywall_annual_discount'.tr,
                        isPremiumAccent: true,
                        delayMs: 600,
                      ),

                      const SizedBox(height: 40),
                    ]),
                  ),
                ),
              ],
            ),
          ),

          // Loading overlay during emulation
          Obx(() {
            if (controller.isPurchasing.value) {
              return Container(
                color: Colors.black.withValues(alpha: 0.8),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.primary,
                            ),
                            strokeWidth: 3,
                          )
                          .animate(onPlay: (c) => c.repeat())
                          .scale(
                            begin: const Offset(1, 1),
                            end: const Offset(1.15, 1.15),
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInOut,
                          ),
                      const SizedBox(height: 24),
                      const Text(
                            'Обработка платежа...',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                          .animate()
                          .fade(duration: 400.ms)
                          .scale(begin: const Offset(0.9, 0.9)),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Widget _buildSubscriptionCard({
    required BuildContext context,
    required SubscriptionPlan type,
    required String title,
    required String subtitle,
    required String price,
    required List<String> benefits,
    required String? badgeText,
    required bool isPremiumAccent,
    required int delayMs,
  }) {
    final themeColor = isPremiumAccent ? AppColors.accent : AppColors.primary;

    return Obx(() {
          final isSelected = controller.selectedPlan.value == type;

          return GestureDetector(
            onTap: () => controller.selectPlan(type),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected
                      ? themeColor
                      : isPremiumAccent
                      ? themeColor.withValues(alpha: 0.25)
                      : Colors.white.withValues(alpha: 0.1),
                  width: isSelected ? 2.5 : 1.5,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: themeColor.withValues(alpha: 0.2),
                          blurRadius: 20,
                          spreadRadius: 1,
                        ),
                      ]
                    : [],
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Header (Title, Subtitle & Badge)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: isSelected ? themeColor : Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                subtitle,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (badgeText != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.accent.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.accent.withValues(alpha: 0.4),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              badgeText,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: AppColors.accent,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    const Divider(color: Colors.white10),
                    const SizedBox(height: 16),

                    // 2. Benefits list inside the card
                    ...benefits.map(
                      (benefit) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 18,
                              color: isPremiumAccent
                                  ? AppColors.accent
                                  : AppColors.primary,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                benefit,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white70,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    const Divider(color: Colors.white10),
                    const SizedBox(height: 16),

                    // 3. Price & Continue button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Стоимость',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              price,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Ensure we select this plan first, then purchase
                            controller.selectPlan(type);
                            controller.purchaseSubscription();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: themeColor,
                            foregroundColor: AppColors.textContrast,
                            elevation: isSelected ? 4 : 1,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'paywall_btn_continue'.tr,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: AppColors.textContrast,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        })
        .animate()
        .fade(delay: delayMs.ms, duration: 500.ms)
        .slideY(begin: 0.15, end: 0, curve: Curves.easeOutQuad);
  }
}
