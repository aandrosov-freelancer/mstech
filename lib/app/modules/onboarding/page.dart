import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../core/values/colors.dart';
import 'controller.dart';

class OnboardingPage extends GetView<OnboardingController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo/Name with custom styling
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.local_pizza,
                          color: Colors.white,
                          size: 20,
                        ),
                      ).animate().scale(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOutBack,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'DuckDuckPizza',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                      ),
                    ],
                  ),
                  // Skip button (only shown on page 1)
                  Obx(
                    () => AnimatedOpacity(
                      opacity: controller.currentPageIndex.value == 0
                          ? 1.0
                          : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: IgnorePointer(
                        ignoring: controller.currentPageIndex.value != 0,
                        child: TextButton(
                          onPressed: () async {
                            await controller.repository.completeOnboarding();
                            Get.offAllNamed('/home');
                          },
                          child: Text(
                            'Пропустить'.tr,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Onboarding Pages Content
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                physics: const BouncingScrollPhysics(),
                children: [_buildPage1(context), _buildPage2(context)],
              ),
            ),

            // Bottom Navigation Area
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Dot Indicators
                      Row(
                        children: List.generate(2, (index) {
                          return Obx(() {
                            final isActive =
                                controller.currentPageIndex.value == index;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.only(right: 8),
                              height: 8,
                              width: isActive ? 24 : 8,
                              decoration: BoxDecoration(
                                color: isActive
                                    ? AppColors.activeDot
                                    : AppColors.inactiveDot,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            );
                          });
                        }),
                      ),

                      // Continue/Start button
                      Obx(() {
                        final isLastPage =
                            controller.currentPageIndex.value == 1;
                        return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColors.primary,
                                    Color(0xFFFF8533),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.4,
                                    ),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: controller.handleContinue,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      isLastPage
                                          ? 'btn_start'.tr
                                          : 'btn_continue'.tr,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .animate(target: isLastPage ? 1.0 : 0.0)
                            .scale(
                              duration: const Duration(milliseconds: 300),
                              begin: const Offset(0.95, 0.95),
                              end: const Offset(1.05, 1.05),
                              curve: Curves.easeInOut,
                            );
                      }),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage1(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: .stretch,
        children: [
          const SizedBox(height: 20),
          // Illustration Box
          SizedBox(
            height: 300,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background radial glow
                Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.18),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ).animate().scale(
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.easeOutBack,
                ),

                // Premium Pizza Slice Icon in center
                Positioned(
                  child:
                      Container(
                            padding: const EdgeInsets.all(40),
                            decoration: BoxDecoration(
                              color: AppColors.cardBg,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.2),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.local_pizza,
                              color: AppColors.accent,
                              size: 110,
                            ),
                          )
                          .animate()
                          .fade(duration: const Duration(milliseconds: 600))
                          .scale(
                            duration: const Duration(milliseconds: 800),
                            begin: const Offset(0.5, 0.5),
                            curve: Curves.elasticOut,
                          )
                          .then()
                          .animate(onPlay: (c) => c.repeat(reverse: true))
                          .move(
                            begin: const Offset(0, 0),
                            end: const Offset(0, -8),
                            duration: const Duration(seconds: 2),
                            curve: Curves.easeInOut,
                          ),
                ),

                // Floating Glassmorphic Search Bar
                Positioned(
                  bottom: 30,
                  child:
                      Container(
                            width: 260,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.overlay.withValues(alpha: 0.85),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.08),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.4),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.search,
                                  color: AppColors.primary,
                                  size: 20,
                                ).animate().scale(
                                  delay: const Duration(milliseconds: 600),
                                  duration: const Duration(milliseconds: 300),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Ингредиенты:'.tr,
                                        style: const TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      const Text(
                                        'Томаты, Сыр, Грибы',
                                        style: TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                          .animate()
                          .fade(
                            delay: const Duration(milliseconds: 400),
                            duration: const Duration(milliseconds: 500),
                          )
                          .slideY(
                            begin: 0.4,
                            end: 0,
                            curve: Curves.easeOutBack,
                          ),
                ),

                // Floating Badge 1
                Positioned(
                  top: 20,
                  left: 30,
                  child: _buildFloatingBadge('🍅 Томаты')
                      .animate()
                      .fade(delay: const Duration(milliseconds: 700))
                      .scale(curve: Curves.easeOutBack)
                      .then()
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .move(
                        begin: const Offset(0, 0),
                        end: const Offset(0, 6),
                        duration: const Duration(milliseconds: 1600),
                        curve: Curves.easeInOut,
                      ),
                ),

                // Floating Badge 2
                Positioned(
                  top: 40,
                  right: 25,
                  child: _buildFloatingBadge('🧀 Сыр Моцарелла')
                      .animate()
                      .fade(delay: const Duration(milliseconds: 900))
                      .scale(curve: Curves.easeOutBack)
                      .then()
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .move(
                        begin: const Offset(0, 0),
                        end: const Offset(0, -6),
                        duration: const Duration(milliseconds: 1800),
                        curve: Curves.easeInOut,
                      ),
                ),

                // Floating Badge 3
                Positioned(
                  bottom: 90,
                  left: 20,
                  child: _buildFloatingBadge('🍄 Грибы')
                      .animate()
                      .fade(delay: const Duration(milliseconds: 1100))
                      .scale(curve: Curves.easeOutBack)
                      .then()
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .move(
                        begin: const Offset(0, 0),
                        end: const Offset(0, 5),
                        duration: const Duration(milliseconds: 1400),
                        curve: Curves.easeInOut,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Title & Description
          Text(
                'onboarding_p1_title'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w900,
                  fontSize: 26,
                  height: 1.3,
                ),
              )
              .animate()
              .fade(duration: const Duration(milliseconds: 500))
              .slideY(begin: 0.2, end: 0, curve: Curves.easeOut),
          const SizedBox(height: 16),
          Text(
                'onboarding_p1_subtitle'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  height: 1.5,
                ),
              )
              .animate()
              .fade(
                delay: const Duration(milliseconds: 200),
                duration: const Duration(milliseconds: 500),
              )
              .slideY(begin: 0.2, end: 0, curve: Curves.easeOut),
        ],
      ),
    );
  }

  Widget _buildPage2(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: .stretch,
        children: [
          const SizedBox(height: 20),
          // Illustration Box
          SizedBox(
            height: 300,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background radial glow
                Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.accent.withValues(alpha: 0.12),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ).animate().scale(
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.easeOutBack,
                ),

                // Premium Pizza Plate Stack
                Positioned(
                  child:
                      Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.cardBg,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.accent.withValues(alpha: 0.2),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Large base dish plate
                                const Icon(
                                  Icons.album,
                                  color: AppColors.overlay,
                                  size: 150,
                                ),
                                // Inner custom delicious design representation
                                const Icon(
                                      Icons.local_pizza,
                                      color: AppColors.primary,
                                      size: 110,
                                    )
                                    .animate(onPlay: (c) => c.repeat())
                                    .rotate(
                                      delay: const Duration(seconds: 2),
                                      duration: const Duration(seconds: 15),
                                    ),
                              ],
                            ),
                          )
                          .animate()
                          .fade(duration: const Duration(milliseconds: 600))
                          .scale(
                            duration: const Duration(milliseconds: 800),
                            begin: const Offset(0.5, 0.5),
                            curve: Curves.elasticOut,
                          )
                          .then()
                          .animate(onPlay: (c) => c.repeat(reverse: true))
                          .move(
                            begin: const Offset(0, 0),
                            end: const Offset(0, -6),
                            duration: const Duration(milliseconds: 2200),
                            curve: Curves.easeInOut,
                          ),
                ),

                // Fast Delivery Badge
                Positioned(
                  bottom: 30,
                  child:
                      Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.overlay,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.accent.withValues(alpha: 0.3),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.4),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.flash_on,
                                  color: AppColors.accent,
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Молниеносная доставка ⚡️',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                          .animate()
                          .fade(
                            delay: const Duration(milliseconds: 400),
                            duration: const Duration(milliseconds: 500),
                          )
                          .slideY(
                            begin: 0.4,
                            end: 0,
                            curve: Curves.easeOutBack,
                          ),
                ),

                // Floating Badge 1
                Positioned(
                  top: 30,
                  left: 20,
                  child: _buildFloatingBadge('🍕 Авторские рецепты')
                      .animate()
                      .fade(delay: const Duration(milliseconds: 700))
                      .scale(curve: Curves.easeOutBack)
                      .then()
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .move(
                        begin: const Offset(0, 0),
                        end: const Offset(0, -5),
                        duration: const Duration(milliseconds: 1500),
                        curve: Curves.easeInOut,
                      ),
                ),

                // Floating Badge 2
                Positioned(
                  top: 40,
                  right: 15,
                  child: _buildFloatingBadge('🔥 Горячая из печи')
                      .animate()
                      .fade(delay: const Duration(milliseconds: 900))
                      .scale(curve: Curves.easeOutBack)
                      .then()
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .move(
                        begin: const Offset(0, 0),
                        end: const Offset(0, 6),
                        duration: const Duration(milliseconds: 1900),
                        curve: Curves.easeInOut,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Title & Description
          Text(
                'onboarding_p2_title'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w900,
                  fontSize: 26,
                  height: 1.3,
                ),
              )
              .animate()
              .fade(duration: const Duration(milliseconds: 500))
              .slideY(begin: 0.2, end: 0, curve: Curves.easeOut),
          const SizedBox(height: 16),
          Text(
                'onboarding_p2_subtitle'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  height: 1.5,
                ),
              )
              .animate()
              .fade(
                delay: const Duration(milliseconds: 200),
                duration: const Duration(milliseconds: 500),
              )
              .slideY(begin: 0.2, end: 0, curve: Curves.easeOut),
        ],
      ),
    );
  }

  Widget _buildFloatingBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
