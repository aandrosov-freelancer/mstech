import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/values/colors.dart';
import '../../data/model/pizza_model.dart';
import 'repository.dart';

class HomeController extends GetxController {
  final HomeRepository repository;

  HomeController({required this.repository});

  final pizzas = <PizzaModel>[].obs;
  final isLoading = true.obs;
  final searchQuery = ''.obs;
  final selectedIngredients = <String>[].obs;

  // Cart state: Map<PizzaId, Quantity>
  final cart = <String, int>{}.obs;

  final subscriptionType = 'none'.obs;

  late final TextEditingController searchTextController;

  @override
  void onInit() {
    super.onInit();
    searchTextController = TextEditingController();
    loadSubscription();
    fetchPizzas();
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }

  Future<void> fetchPizzas() async {
    isLoading.value = true;
    try {
      final list = await repository.getPizzas();
      pizzas.assignAll(list);
    } catch (e) {
      debugPrint('Error loading pizzas: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void loadSubscription() {
    subscriptionType.value = repository.getSubscriptionType();
  }

  Future<void> openPaywall() async {
    await Get.toNamed('/paywall');
    loadSubscription();
  }

  Future<void> resetSubscription() async {
    await repository.clearSubscription();
    loadSubscription();
    Get.snackbar(
      'Успех'.tr,
      'home_premium_reset_success'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1E1E1E),
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
    );
  }

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

  // Real-time intelligent search & ingredient tag filtering logic (AND filter logic)
  List<PizzaModel> get filteredPizzas {
    return pizzas.where((pizza) {
      // 1. Horizontal pill active ingredients filter:
      // A pizza must contain all currently selected ingredients.
      if (selectedIngredients.isNotEmpty) {
        final matchesAllTags = selectedIngredients.every(
          (tag) => pizza.ingredients.any(
            (ing) => ing.toLowerCase() == tag.toLowerCase(),
          ),
        );
        if (!matchesAllTags) return false;
      }

      // 2. Text Search Query:
      // Matches on the pizza name, short description, or any individual ingredient
      if (searchQuery.isNotEmpty) {
        final query = searchQuery.value.trim().toLowerCase();
        final nameMatches = pizza.name.toLowerCase().contains(query);
        final descMatches = pizza.description.toLowerCase().contains(query);
        final ingredientMatches = pizza.ingredients.any(
          (ing) => ing.toLowerCase().contains(query),
        );
        return nameMatches || descMatches || ingredientMatches;
      }

      return true;
    }).toList();
  }

  void toggleIngredient(String tag) {
    if (selectedIngredients.contains(tag)) {
      selectedIngredients.remove(tag);
    } else {
      selectedIngredients.add(tag);
    }
  }

  void clearFilters() {
    searchQuery.value = '';
    searchTextController.clear();
    selectedIngredients.clear();
  }

  // Reactive Cart actions
  void addToCart(PizzaModel pizza) {
    final count = cart[pizza.id] ?? 0;
    cart[pizza.id] = count + 1;

    Get.closeAllSnackbars();
    Get.snackbar(
      'Добавлено!'.tr,
      '${pizza.name} добавлена в корзину.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.cardBg,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      borderWidth: 1,
      borderColor: AppColors.primary.withValues(alpha: 0.3),
      mainButton: TextButton(
        onPressed: () {
          removeFromCart(pizza);
          Get.closeAllSnackbars();
        },
        child: const Text(
          'Отменить',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void removeFromCart(PizzaModel pizza) {
    final count = cart[pizza.id] ?? 0;
    if (count <= 1) {
      cart.remove(pizza.id);
    } else {
      cart[pizza.id] = count - 1;
    }
  }

  int get totalCartCount {
    return cart.values.fold(0, (sum, count) => sum + count);
  }
}
