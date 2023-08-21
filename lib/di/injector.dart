import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:handover/view_model/barrel_view_model.dart';

final GetIt getIt = GetIt.I;

Future<void> injectorSetup() async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPref);

  getIt.registerSingleton<RateViewModel>(RateViewModel());
  getIt.registerSingleton<BusDriversViewModel>(BusDriversViewModel());
  getIt.registerSingleton<SplashScreenViewModel>(SplashScreenViewModel());
  getIt.registerSingleton<LanguageViewModel>(LanguageViewModel());
}
