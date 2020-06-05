import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class AppProvider extends ChangeNotifier {
  AppProvider();

  ThemeData theme = Constants.lightTheme;
  Key key = UniqueKey();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  String appVersion;

  //

  void setKey(value) {
    key = value;
    notifyListeners();
  }

  void setNavigatorKey(value) {
    navigatorKey = value;
    notifyListeners();
  }
}
