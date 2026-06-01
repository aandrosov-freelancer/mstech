import 'package:get/get.dart';
import '../../data/model/pizza_model.dart';
import '../../data/provider/storage_provider.dart';

class HomeRepository {
  final StorageProvider _storageProvider = Get.find<StorageProvider>();

  // Realistic mock pizzas database with high-resolution Unsplash images
  static final List<PizzaModel> _mockPizzas = [
    PizzaModel(
      id: 'margherita',
      name: 'Маргарита',
      description:
          'Классический итальянский рецепт с сочными томатами, ароматным базиликом и нежной моцареллой.',
      imageUrl:
          'https://images.unsplash.com/photo-1604068549290-dea0e4a305ca?q=80&w=600&auto=format&fit=crop',
      price: 499.0,
      ingredients: ['томаты', 'моцарелла', 'базилик', 'соус'],
    ),
    PizzaModel(
      id: 'pepperoni',
      name: 'Пепперони',
      description:
          'Пикантные слайсы колбасы пепперони, много сыра моцарелла и фирменный томатный соус.',
      imageUrl:
          'https://images.unsplash.com/photo-1628840042765-356cda07504e?q=80&w=600&auto=format&fit=crop',
      price: 549.0,
      ingredients: ['пепперони', 'моцарелла', 'томаты', 'соус', 'сыр'],
    ),
    PizzaModel(
      id: 'four_cheese',
      name: 'Четыре Сыра',
      description:
          'Изысканное сочетание сыров моцарелла, пармезан, чеддер и благородного дорблю с нежным соусом.',
      imageUrl:
          'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=600&auto=format&fit=crop',
      price: 629.0,
      ingredients: [
        'моцарелла',
        'пармезан',
        'чеддер',
        'дорблю',
        'сыр',
        'сливочный соус',
      ],
    ),
    PizzaModel(
      id: 'bbq_chicken',
      name: 'Барбекю Цыпленок',
      description:
          'Нежное куриное филе, хрустящий бекон, сладкий лук, моцарелла и ароматный соус барбекю.',
      imageUrl:
          'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?q=80&w=600&auto=format&fit=crop',
      price: 599.0,
      ingredients: [
        'курица',
        'бекон',
        'томаты',
        'лук',
        'соус барбекю',
        'моцарелла',
        'сыр',
      ],
    ),
    PizzaModel(
      id: 'vegetarian',
      name: 'Вегетарианская',
      description:
          'Свежие шампиньоны, сладкий перец, томаты, красный лук, маслины и сыр моцарелла.',
      imageUrl:
          'https://images.unsplash.com/photo-1571066811602-71683a3f680d?q=80&w=600&auto=format&fit=crop',
      price: 479.0,
      ingredients: [
        'томаты',
        'грибы',
        'шампиньоны',
        'перец',
        'маслины',
        'лук',
        'моцарелла',
        'сыр',
      ],
    ),
    PizzaModel(
      id: 'seafood',
      name: 'Морская премиум',
      description:
          'Сочные тигровые креветки, слабосоленый лосось, томаты черри, моцарелла и сливочный соус.',
      imageUrl:
          'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?q=80&w=600&auto=format&fit=crop',
      price: 699.0,
      ingredients: [
        'лосось',
        'креветки',
        'моцарелла',
        'черри',
        'сливочный соус',
        'рыба',
        'сыр',
      ],
    ),
  ];

  Future<List<PizzaModel>> getPizzas() async {
    // Emulate server loading latency
    await Future.delayed(const Duration(milliseconds: 600));
    return List.from(_mockPizzas);
  }

  Future<bool> resetOnboarding() {
    return _storageProvider.setHasSeenOnboarding(false);
  }

  String getSubscriptionType() {
    return _storageProvider.subscriptionType;
  }

  Future<void> clearSubscription() {
    return _storageProvider.clearSubscription();
  }
}
