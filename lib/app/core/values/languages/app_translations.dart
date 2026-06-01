import 'package:get/get.dart';
import 'from/ru_ru.dart';
import 'from/en_us.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'ru_RU': ruRU, 'en_US': enUS};
}
