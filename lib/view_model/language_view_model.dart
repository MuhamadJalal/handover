import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:handover/di/injector.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:handover/helper/barrel_helper.dart';

class LanguageViewModel extends GetxController {
  RxString selectedLanguage = RxString('${getIt<SharedPreferences>().get(AppRepoSharedPrefKeys().languageCodeSharedPref) ?? 'ar'}');
  Locale getLocale() => Locale('${getIt<SharedPreferences>().get(AppRepoSharedPrefKeys().languageCodeSharedPref) ?? 'ar'}');

  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);

    GetStorageServices().saveToSharedPref(AppRepoSharedPrefKeys().languageCodeSharedPref, lang);

    Get.forceAppUpdate();

    'Get.updateLocale ${Get.locale}'.debug(this);
    'GetStorageServices .updateLocale ${GetStorageServices().readFromSharedPref(AppRepoSharedPrefKeys().languageCodeSharedPref)}'.debug(this);
  }

  // Finds language in `languages` list and returns it as Locale
  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < AppTranslations.languages.length; i++) {
      // 'lang.toLowerCase() ${lang.toLowerCase()} and ${languages[i].toLowerCase()} with ${languages[i].toLowerCase().startsWith(lang.toLowerCase())}'.debug(this);
      if (AppTranslations.languages[i].toLowerCase().startsWith(lang.toLowerCase())) {
        return AppTranslations.locales[i];
      }
    }
    return Get.locale;
  }
}
