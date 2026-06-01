import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/core/values/colors.dart';
import 'app/core/values/languages/app_translations.dart';
import 'app/data/provider/storage_provider.dart';
import 'app/data/services/subscription_service.dart';
import 'app/routes/pages.dart';
import 'app/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize storage provider before launching the app
  final storageProvider = await Get.putAsync(() => StorageProvider().init());

  // Initialize subscription service globally
  Get.put(SubscriptionService());

  // Decide initial route dynamically based on stored onboarding state
  final String initialRoute = storageProvider.hasSeenOnboarding
      ? AppRoutes.home
      : AppRoutes.onboarding;

  runApp(MainApp(initialRoute: initialRoute));
}

class MainApp extends StatelessWidget {
  final String initialRoute;

  const MainApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DuckDuckPizza',
      debugShowCheckedModeBanner: false,

      // Localization Configuration using GetX capabilities
      translations: AppTranslations(),
      locale: const Locale('ru', 'RU'),
      fallbackLocale: const Locale('en', 'US'),

      // Theme Configuration with pizza premium dark design
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkBg,
        primaryColor: AppColors.primary,
        useMaterial3: true,
      ),

      // Router Configuration
      initialRoute: initialRoute,
      getPages: AppPages.pages,
    );
  }
}
