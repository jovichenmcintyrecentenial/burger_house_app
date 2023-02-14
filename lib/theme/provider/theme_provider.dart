import 'package:flutter/foundation.dart';

import '../app_theme.dart';
import '../default_theme.dart';

class ThemeProvider extends ChangeNotifier {
  AppTheme theme = DefaultTheme();

  void setTheme(AppTheme appTheme) {
    theme = appTheme;
    notifyListeners();
  }
}
