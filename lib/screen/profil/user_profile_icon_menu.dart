import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:petani_kopi/model/user_profile_menu.dart';
import 'package:petani_kopi/theme/colors.dart';

class UserProfileIconMenu extends StatelessWidget {
  final Function(String?) onSelected;
  const UserProfileIconMenu({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      icon: const Icon(
        IconlyBold.profile,
        color: backgroundColor,
      ),
      onSelected: (value) => onSelected(value),
      itemBuilder: (BuildContext context) {
        return StaticProfileMenu.userMenu
            .map(
              (e) => PopupMenuItem<String>(
                height: 30,
                value: e.text,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        e.icon,
                        color: mainColor,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        e.text!,
                        style: const TextStyle(color: mainColor),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList();
      },
    );
  }
}
