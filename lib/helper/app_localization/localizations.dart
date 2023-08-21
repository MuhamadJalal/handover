import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handover/di/injector.dart';

// import 'package:get_storage/get_storage.dart';
import 'package:handover/helper/app_repo_constants/app_repo_shared_pref_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTranslations extends Translations {
  // Default locale
  static Locale locale =
      getIt<SharedPreferences>().get(AppRepoSharedPrefKeys().languageCodeSharedPref) == null || getIt<SharedPreferences>().get(AppRepoSharedPrefKeys().languageCodeSharedPref).toString().isEmpty
          ? const Locale('en', 'US')
          : Locale('${getIt<SharedPreferences>().get(AppRepoSharedPrefKeys().languageCodeSharedPref)}');

  // static const locale = Locale('en', 'US');

  // fallbackLocale saves the day when the locale gets in trouble
  // static const fallbackLocale = Locale('ar', 'EG');
  //
  static const fallbackLocale = Locale('en', 'US');

  // Supported languages
  // Needs to be same order with locales
  static final languages = [
    'Arabic',
    'English',
  ];

  // Supported locales
  // Needs to be same order with languages
  static final locales = [
    const Locale('ar', 'EG'),
    const Locale('en', 'US'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'ar_EG': {
          'title': 'HandOver',
          'no_data_found': 'لا يوجد بيانات',
          'successfullyUpdated': 'تم تحديث بنجاح',
          'save': 'حفظ',
          'cancel': 'إلغاء',
          'submit': 'تأكيد',
          'edit': 'تعديل',
          'remove': 'حذف',
          'ok': 'تم',
          'confirm': 'تأكيد',
          'start': 'بدء',
          'update': 'تحديث',
          'error': 'خطأ',
          "onTheWay": "في الطريق",
          "pickedDelivery": "تسليم مستلم",
          "nearDelivery": "بالقرب من وجهة التسليم",
          'deliveredPackage': 'تسليم الحزمة',
          "pickupTime": "وقت الاستلام",
          "deliveryTime": "وقت التسليم",
          "total": "الاجمالي",
          'startTracking': 'بدء تتبع',
          'declaration': 'توضيح',
          'prepareFakeTrip': 'تحضير رحلة وهمية',
          "selectPoint": "حدد نقطة",
          "selectStartPoint": "حدد نقطة البداية",
          "selectEndPoint": "حدد نقطة النهاية",
          "startPoint": "نقطة البداية",
          "endPoint": "نقطة النهاية",
          "allowLocationAccessMsg": "برجاء السماح بالوصول الي موقعك",
          "currentOrder": "الطلب الحلي",
          '': '',
        },
        'en_US': {
          'title': 'HandOver',
          'no_data_found': 'no data found',
          'successfullyUpdated': 'updated successfully',
          'save': 'save',
          'cancel': 'cancel',
          'submit': 'submit',
          'edit': 'modify',
          'remove': 'remove',
          'ok': 'Done',
          'confirm': 'confirm',
          'start': 'start',
          'update': 'update',
          'error': 'error',
          'onTheWay': 'on the way',
          'pickedDelivery': 'picked up delivery',
          'nearDelivery': 'near delivery destination',
          'deliveredPackage': 'delivered package',
          'pickupTime': 'pickup time',
          'deliveryTime': 'Delivery time',
          'total': 'total',
          'startTracking': 'start Tracking',
          'declaration': 'declaration',
          'prepareFakeTrip': 'prepare fake trip',
          'selectPoint': 'select point',
          'selectStartPoint': 'select start point',
          'selectEndPoint': 'select end point',
          'startPoint': 'start point',
          'endPoint': 'end point',
          'allowLocationAccessMsg': 'please allow access to your location!',
          'currentOrder': 'current order',
          '': '',
        },
      };

  static String get title => 'title'.tr;
  static String get noDataFoundMessage => 'no_data_found'.tr;
  static String get successfullyUpdated => 'successfullyUpdated'.tr;
  static String get save => 'save'.tr;
  static String get cancel => 'cancel'.tr;
  static String get submit => 'submit'.tr;
  static String get edit => 'edit'.tr;
  static String get remove => 'remove'.tr;
  static String get ok => 'ok'.tr;
  static String get confirm => 'confirm'.tr;
  static String get start => 'start'.tr;
  static String get update => 'update'.tr;
  static String get error => 'error'.tr;
  static String get onTheWay => 'onTheWay'.tr;
  static String get pickedDelivery => 'pickedDelivery'.tr;
  static String get nearDelivery => 'nearDelivery'.tr;
  static String get deliveredPackage => 'deliveredPackage'.tr;
  static String get pickupTime => 'pickupTime'.tr;
  static String get deliveryTime => 'deliveryTime'.tr;
  static String get total => 'total'.tr;
  static String get startTracking => 'startTracking'.tr;
  static String get declaration => 'declaration'.tr;
  static String get prepareFakeTrip => 'prepareFakeTrip'.tr;
  static String get selectPoint => 'selectPoint'.tr;
  static String get selectStartPoint => 'selectStartPoint'.tr;
  static String get selectEndPoint => 'selectEndPoint'.tr;
  static String get startPoint => 'startPoint'.tr;
  static String get endPoint => 'endPoint'.tr;
  static String get allowLocationAccessMsg => 'allowLocationAccessMsg'.tr;
  static String get currentOrder => 'currentOrder'.tr;

// static String get  => ''.tr;
}
