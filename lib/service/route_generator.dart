// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:petani_kopi/screen/card/cart.dart';
import 'package:petani_kopi/screen/card/notification.dart';
import 'package:petani_kopi/screen/card/payment.dart';
import 'package:petani_kopi/screen/card/payment_success.dart';
import 'package:petani_kopi/screen/dashboard/dashboard_page.dart';
import 'package:petani_kopi/helper/page.dart';
import 'package:petani_kopi/screen/home/home_page.dart';
import 'package:petani_kopi/screen/login/login_main.dart';
import 'package:petani_kopi/screen/profil/edit_profile.dart';
import 'package:petani_kopi/screen/profil/profil_page.dart';
import 'package:petani_kopi/screen/profil/setting_page.dart';
import 'package:petani_kopi/screen/seller/my_shop_page.dart';
import 'package:petani_kopi/screen/seller/tambah_product.dart';
import 'package:petani_kopi/screen/seller/upload_product.dart';

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
            builder: (_) => const HomePage(),
          );
        case Pages.dasboardPage:
          return CupertinoPageRoute(
            builder: (_) => const DashboardPage(),
          );
        case Pages.confrimOrder:
          return CupertinoPageRoute(
            builder: (_) => const PaymentPage(),
          );
        case Pages.cardPage:
          return CupertinoPageRoute(
            builder: (_) => const CardPage(),
          );
        case Pages.profilPage:
          return CupertinoPageRoute(
            builder: (_) => const ProfilePage(),
          );
        case Pages.editProfile:
          return CupertinoPageRoute(
            builder: (_) => const EditProfile(),
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
          Map arg = settings.arguments as Map<String, dynamic>;
          return CupertinoPageRoute(
            builder: (_) => UploadProduct(isRegister: arg['isRegister']),
          );
        case Pages.myShopPage:
          return CupertinoPageRoute(
            builder: (_) => const MyShopScreen(),
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
