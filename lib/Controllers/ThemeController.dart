import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/app_constants.dart';

class ThemeController extends GetxController {
  SharedPreferences? sharedPreferences;

  final RxBool _darkTheme = false.obs;
  bool get darkTheme => _darkTheme.value;

  @override
  void onInit() {
    super.onInit();
    _loadCurrentTheme();
  }

  Future<void> toggleTheme() async {
    sharedPreferences = await SharedPreferences.getInstance();
    _darkTheme.toggle();
    sharedPreferences!.setBool(AppConstants.THEME, _darkTheme.value);
  }

  Future<void> _loadCurrentTheme() async {
    sharedPreferences = await SharedPreferences.getInstance();
    _darkTheme.value = sharedPreferences!.getBool(AppConstants.THEME) ?? false;
  }
}