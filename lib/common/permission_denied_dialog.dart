import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:petani_kopi/screen/profil/profile_page_button.dart';
import 'package:petani_kopi/service/jump.dart';
import 'package:petani_kopi/theme/colors.dart';

class DeniedDialog extends StatelessWidget {
  final String subHeading;
  const DeniedDialog({
    Key? key,
    this.subHeading = 'open settings to change permission settings',
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      title: const Text(
        'Permission need to continue',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Text(
        subHeading,
        style: const TextStyle(
          color: mainColor,
        ),
      ),
      actions: <Widget>[
        ProfileButtonCancel(
          onTap: () => Jump.back(),
          text: 'Cancel',
        ),
        ProfileButtonConfirm(
          onTap: () => openAppSettings(),
          text: 'Open Settings',
        ),
      ],
    );
  }
}

showDeniedDialog(String warning) {
  showDialog(
    context: Jump.context(),
    builder: (context) {
      return DeniedDialog(subHeading: warning);
    },
  );
}
