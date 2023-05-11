import 'package:flutter/foundation.dart';
 import 'package:shared_preferences/shared_preferences.dart';

import '../helper/app_constants.dart';

class ThemeProvider with ChangeNotifier {
    SharedPreferences ? sharedPreferences;
  ThemeProvider({this.sharedPreferences}) {
    _loadCurrentTheme();
  }

  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;
   void toggleTheme()async {
     sharedPreferences =  await SharedPreferences.getInstance();
    _darkTheme = !_darkTheme;
    sharedPreferences!.setBool(AppConstants.THEME, _darkTheme);
    notifyListeners();
  }

  void _loadCurrentTheme() async {
    sharedPreferences =  await SharedPreferences.getInstance();
    _darkTheme = sharedPreferences!.getBool(AppConstants.THEME) ?? false;
    notifyListeners();
  }
}
