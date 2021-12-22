import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petani_kopi/bloc/auth_bloc/auth_bloc.dart';
import 'package:petani_kopi/bloc/auth_bloc/auth_event.dart';
import 'package:petani_kopi/bloc/auth_bloc/auth_state.dart';
import 'package:petani_kopi/common/common_avatar.dart';
import 'package:petani_kopi/helper/page.dart';
import 'package:petani_kopi/model/user_profile_menu.dart';
import 'package:petani_kopi/model/users.dart';
import 'package:petani_kopi/screen/profil/user_profile_icon_menu.dart';
import 'package:petani_kopi/service/jump.dart';
import 'package:petani_kopi/theme/app_theme.dart';
import 'package:petani_kopi/theme/colors.dart';

class ProfileBar extends StatefulWidget {
  final double opacity;
  final Users user;
  final Function() changeImage;
  final bool isUser;
  const ProfileBar({
    Key? key,
    this.opacity = 0,
    this.isUser = true,
    required this.user,
    required this.changeImage,
  }) : super(key: key);

  @override
  _ProfileBarState createState() => _ProfileBarState();
}

class _ProfileBarState extends State<ProfileBar> {
  bloc(AuthEvent event) {
    BlocProvider.of<AuthBloc>(context).add(event);
  }

  @override
  Widget build(BuildContext context) {
    return blocListener(
      child: AppBar(
        backgroundColor: const Color(0xFF0d1015),
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Jump.replace(Pages.homePage);
          },
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Jump.replace(Pages.settingPage);
            },
          ),
        ],
      ),
    );
  }

  onSelect(val) {
    if (val == ProfileMenu.logout) {
      bloc(AuthLogout());
    } else {
      widget.changeImage();
    }
  }

  blocListener({required Widget child}) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LogoutDone) {
          Jump.replace(Pages.loginScreen);
        }
      },
      child: child,
    );
  }
}
