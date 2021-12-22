import 'package:flutter/cupertino.dart';
import 'package:iconly/iconly.dart';

class ProfileMenu {
  static const logout = 'Logout';
  static const editImage = 'Edit Image';

  String? text;
  IconData? icon;

  ProfileMenu({this.icon, this.text});
}

class StaticProfileMenu {
  static List<ProfileMenu> userMenu = [
    ProfileMenu(text: ProfileMenu.logout, icon: IconlyLight.logout),
    ProfileMenu(text: ProfileMenu.editImage, icon: IconlyLight.image),
  ];
}
