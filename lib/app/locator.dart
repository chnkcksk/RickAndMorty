import 'package:get_it/get_it.dart';
import 'package:rickandmorty_2/services/api_service.dart';
import 'package:rickandmorty_2/services/preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  final prefs = await SharedPreferences.getInstance();
  locator.registerLazySingleton<PreferencesService>(
    () => PreferencesService(prefs: prefs),
  );
  locator.registerLazySingleton<ApiService>(() => ApiService());
}
