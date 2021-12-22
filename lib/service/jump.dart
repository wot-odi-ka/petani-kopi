import 'package:flutter/material.dart';
import 'package:petani_kopi/service/locator.dart';

class Jump {
  static Future<dynamic> to(String route) {
    return locator<NavigatorService>().navigateTo(route);
  }

  static Future<dynamic> toArg(String route, dynamic obj) {
    return locator<NavigatorService>().navigateToWithArgmnt(route, obj);
  }

  static Future<dynamic> replace(String route) {
    return locator<NavigatorService>().navigateReplaceTo(route);
  }

  static back([dynamic val]) {
    return locator<NavigatorService>().goBack(val);
  }

  static BuildContext context() {
    return locator<NavigatorService>().navigatorKey.currentContext!;
  }
}
