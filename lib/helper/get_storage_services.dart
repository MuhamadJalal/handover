import 'package:handover/di/injector.dart';
import 'package:handover/helper/extensions/debugger_extension.dart';
import 'package:handover/view_model/firebase_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStorageServices {
  final SharedPreferences prefs = getIt<SharedPreferences>();

  GetStorageServices._internal();

  static final GetStorageServices _instance = GetStorageServices._internal();

  factory GetStorageServices() => _instance;

  saveToSharedPref(String storageKey, var storageValue, {bool isMap = false}) {
    'saveToSharedPref type ${storageValue.runtimeType} - storageKey $storageKey - storageValue $storageValue'.debug(this);
    if (storageValue == null) return;
    // if(isMap) return prefs.setString(storageKey, jsonEncode(storageValue));
    'saveToSharedPref type 1'.debug(this);
    if (storageValue is String) return prefs.setString(storageKey, storageValue);
    'saveToSharedPref type 2'.debug(this);
    if (storageValue is bool) return prefs.setBool(storageKey, storageValue);
    'saveToSharedPref type 3'.debug(this);
    if (storageValue is double) return prefs.setDouble(storageKey, storageValue);
    'saveToSharedPref type 4'.debug(this);
    if (storageValue is int) return prefs.setInt(storageKey, storageValue);
  }

  readFromSharedPref(String storageKey) {
    dynamic savedValue = prefs.get(storageKey);
    'readFromSharedPref(String $storageKey) savedValue $savedValue'.debug(this);
    return savedValue;
  }

  removeWithGet(String storageKey) => prefs.remove(storageKey);

  clearStorageWithLogout() {
    prefs.clear();
    FirebaseServices().stopFirebaseMessaging();
  }

  clearGetStorage() => prefs.clear();
}
