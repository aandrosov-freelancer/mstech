import 'package:get/get.dart';
import 'routes.dart';
import '../modules/onboarding/binding.dart';
import '../modules/onboarding/page.dart';
import '../modules/home/binding.dart';
import '../modules/home/page.dart';
import '../modules/paywall/binding.dart';
import '../modules/paywall/page.dart';

abstract class AppPages {
  AppPages._();

  static final pages = [
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingPage(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.paywall,
      page: () => const PaywallPage(),
      binding: PaywallBinding(),
    ),
  ];
}
