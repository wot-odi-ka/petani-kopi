import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:petani_kopi/theme/app_theme.dart';
import 'package:petani_kopi/theme/colors.dart';

class SelectMediaBody extends StatelessWidget {
  final Function() gallery;
  final Function() camera;
  const SelectMediaBody({
    Key? key,
    required this.gallery,
    required this.camera,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        SelectMedia(
          ontap: () => gallery(),
          text: 'Gallery',
          icon: IconlyLight.folder,
        ),
        SelectMedia(
          ontap: () => camera(),
          text: 'Camera',
          icon: IconlyLight.camera,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class SelectMedia extends StatelessWidget {
  final Function() ontap;
  final String text;
  final IconData icon;
  const SelectMedia({
    Key? key,
    required this.ontap,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ontap,
      leading: Icon(icon, color: mainColor),
      trailing: const Icon(IconlyLight.arrow_right_2, color: mainColor),
      title: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Text(
          text,
          style: MyTheme.heading2.copyWith(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
