// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petani_kopi/main.dart';
import 'package:petani_kopi/screen/card/cart.dart';
import 'package:petani_kopi/screen/card/notification.dart';
import 'package:petani_kopi/screen/card/payment.dart';
import 'package:petani_kopi/screen/card/payment_success.dart';
import 'package:petani_kopi/screen/dashboard/dashboard_page.dart';
import 'package:petani_kopi/helper/page.dart';
import 'package:petani_kopi/screen/login/login_main.dart';
import 'package:petani_kopi/screen/profil/profil_page.dart';
import 'package:petani_kopi/screen/profil/setting_page.dart';
import 'package:petani_kopi/screen/seller/my_shop.dart';
import 'package:petani_kopi/screen/seller/seller_page.dart';
import 'package:petani_kopi/screen/seller/tambah_product.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case Pages.loginScreen:
          return CupertinoPageRoute(
            builder: (_) => const LoginMainPage(),
          );
        case Pages.homePage:
          return CupertinoPageRoute(
            builder: (_) => const MyApp(),
          );
        case Pages.dasboardPage:
          return CupertinoPageRoute(
            builder: (_) => const DashboardPage(),
          );
        case Pages.confrimOrder:
          // var map = settings.arguments as Map<String, dynamic>;
          return CupertinoPageRoute(
            builder: (_) => const PaymentPage(),
          );
        case Pages.cardPage:
          return CupertinoPageRoute(
            builder: (_) => const CardPage(),
          );
        case Pages.profilPage:
          // var map = settings.arguments as Map<String, dynamic>;
          return CupertinoPageRoute(
            builder: (_) => const ProfileSettingsPage(),
          );
        case Pages.settingPage:
          return CupertinoPageRoute(
            builder: (_) => const SettingsTwoPage(),
          );
        case Pages.pymentSuccses:
          return CupertinoPageRoute(
            builder: (_) => const PaymentSuccess(),
          );

        case Pages.notivication:
          return CupertinoPageRoute(
            builder: (_) => const NotivicationPage(),
          );

        case Pages.sellerPage:
          return CupertinoPageRoute(
            builder: (_) => const SellerPage(),
          );
        case Pages.myShopPage:
          return CupertinoPageRoute(
            builder: (_) => const MyShopPage(),
          );

        case Pages.tambahProduct:
          return CupertinoPageRoute(
            builder: (_) => const TambahProductPage(),
          );

        default:
          return CupertinoPageRoute(
            builder: (_) => Container(),
          );
      }
    } catch (e) {
      return CupertinoPageRoute(
        builder: (_) => Container(),
      );
    }
  }
}
