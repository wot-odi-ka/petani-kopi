import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:iconly/iconly.dart';
import 'package:petani_kopi/bloc/auth_bloc/auth_bloc.dart';
import 'package:petani_kopi/bloc/auth_bloc/auth_event.dart';
import 'package:petani_kopi/bloc/auth_bloc/auth_state.dart';
import 'package:petani_kopi/bloc/permission_bloc/permission_bloc.dart';
import 'package:petani_kopi/bloc/permission_bloc/permission_event.dart';
import 'package:petani_kopi/bloc/profil_block/profil_block.dart';
import 'package:petani_kopi/bloc/profil_block/profil_event.dart';
import 'package:petani_kopi/bloc/profil_block/profil_state.dart';
import 'package:petani_kopi/common/common_alert_dialog.dart';
import 'package:petani_kopi/common/common_loading.dart';
import 'package:petani_kopi/helper/app_scaler.dart';
import 'package:petani_kopi/helper/constants.dart';
import 'package:petani_kopi/helper/page.dart';
import 'package:petani_kopi/helper/snack_bar.dart';
import 'package:petani_kopi/model/users.dart';
import 'package:petani_kopi/service/jump.dart';
import 'package:petani_kopi/theme/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfilBlock>(
          create: (context) => ProfilBlock()..add(ProfilInitEvent()),
        ),
        BlocProvider<PermissionBloc>(
          create: (context) => PermissionBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
      ],
      child: const ProfileBody(),
    );
  }
}

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  late ScrollController scrollController;
  Users user = Users();

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  bloc(ProfilEvent event) {
    BlocProvider.of<ProfilBlock>(context).add(event);
  }

  permissionBloc(PermissionEvent event) {
    BlocProvider.of<PermissionBloc>(context).add(event);
  }

  logoutBloc(AuthEvent event) {
    BlocProvider.of<AuthBloc>(context).add(event);
  }

  @override
  Widget build(BuildContext context) {
    return blocListener(
      child: Scaffold(
        backgroundColor: backgroundColor,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: mainColor,
          ),
        ),
        body: blocBuilder(
          child: SizedBox(
            height: context.height(),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  Container(
                    width: context.width(),
                    decoration: const BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 35),
                          const Text(
                            'My Account',
                            style: TextStyle(
                              color: backgroundColor,
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 36),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(50),
                                ),
                                child: SizedBox(
                                  width: 80.0,
                                  height: 80.0,
                                  child: BlurHash(
                                    color: mainColor,
                                    hash: user.userImageHash ?? Const.emptyHash,
                                    image: user.userImage ?? Const.emptyImage,
                                    imageFit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.userMail ?? '',
                                    style: const TextStyle(
                                      color: backgroundColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    user.userName ?? '',
                                    style: const TextStyle(
                                      color: backgroundColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 18, top: 8, right: 18),
                    width: context.width(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        Card(
                          elevation: 5,
                          child: ListTile(
                            onTap: () => Jump.to(Pages.editProfile).then((_) {
                              bloc(ProfilInitEvent());
                            }),
                            leading: const Icon(
                              IconlyLight.setting,
                              color: mainColor,
                            ),
                            title: Transform.translate(
                              offset: const Offset(-16, -0),
                              child: const Text(
                                'Edit Profile',
                                style: TextStyle(
                                  color: mainColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            trailing: const Icon(
                              IconlyLight.arrow_right_2,
                              color: mainColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        shopTile(user.userIsSeller ?? false),
                        Column(
                          children: [
                            const SizedBox(height: 8),
                            Card(
                              elevation: 5,
                              child: ListTile(
                                onTap: () => Jump.to(Pages.myOrder),
                                leading: const Icon(
                                  IconlyLight.buy,
                                  color: mainColor,
                                ),
                                title: Transform.translate(
                                  offset: const Offset(-16, -0),
                                  child: const Text(
                                    'My Order',
                                    style: TextStyle(
                                      color: mainColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                trailing: const Icon(
                                  IconlyLight.arrow_right_2,
                                  color: mainColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: user.userIsSeller ?? false,
                          child: Column(
                            children: [
                              const SizedBox(height: 8),
                              Card(
                                elevation: 5,
                                child: ListTile(
                                  onTap: () => Jump.to(Pages.incomingOrder),
                                  leading: const Icon(
                                    IconlyLight.buy,
                                    color: mainColor,
                                  ),
                                  title: Transform.translate(
                                    offset: const Offset(-16, -0),
                                    child: const Text(
                                      'Incoming Order',
                                      style: TextStyle(
                                        color: mainColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  trailing: const Icon(
                                    IconlyLight.arrow_right_2,
                                    color: mainColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Card(
                          elevation: 5,
                          child: ListTile(
                            leading: const Icon(
                              IconlyLight.logout,
                              color: mainColor,
                            ),
                            title: Transform.translate(
                              offset: const Offset(-16, -0),
                              child: const Text(
                                'Log Out',
                                style: TextStyle(
                                  color: mainColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            trailing: const Icon(
                              IconlyLight.arrow_right_2,
                              color: mainColor,
                            ),
                            onTap: () => showLogoutChoice(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showLogoutChoice() {
    return showDialog(
      context: context,
      builder: (context) => CustomDialogBox(
        onTapYes: () => logoutBloc(AuthLogout()),
        descriptions: 'Are you sure you want to logout?',
        title: 'Logout',
        yes: 'Sure',
        no: 'Later',
      ),
    );
  }

  Widget blocBuilder({required Widget child}) {
    return BlocBuilder<ProfilBlock, ProfilState>(
      builder: (context, state) {
        if (state is ProfilOnLoading || state is ProfilInitial) {
          return const CommonLoading();
        } else {
          return child;
        }
      },
    );
  }

  Widget blocListener({required Widget child}) {
    return MultiBlocListener(
      child: child,
      listeners: [
        BlocListener<ProfilBlock, ProfilState>(
          listener: (context, state) {
            if (state is InitUserProfileDone) {
              setState(() {
                user = state.user;
              });
            }
            if (state is UserProfileFailed) {
              context.fail(state.error);
            }
          },
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LogoutDone) {
              Jump.replace(Pages.loginScreen);
            }
          },
        ),
      ],
    );
  }

  Widget shopTile(bool userStatus) {
    if (userStatus) {
      return Card(
        elevation: 5,
        child: ListTile(
          onTap: () => Jump.to(Pages.myShopPage),
          leading: const Icon(
            IconlyLight.bag,
            color: mainColor,
          ),
          title: Transform.translate(
            offset: const Offset(-16, -0),
            child: const Text(
              'My Shop',
              style: TextStyle(
                color: mainColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          trailing: const Icon(
            IconlyLight.arrow_right_2,
            color: mainColor,
          ),
        ),
      );
    } else {
      return Card(
        elevation: 5,
        child: ListTile(
          onTap: () => checkSellerStatus(),
          leading: const Icon(
            IconlyLight.bag,
            color: mainColor,
          ),
          title: Transform.translate(
            offset: const Offset(-16, -0),
            child: const Text(
              'Start Selling',
              style: TextStyle(
                color: mainColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          trailing: const Icon(
            IconlyLight.arrow_right_2,
            color: mainColor,
          ),
        ),
      );
    }
  }

  void checkSellerStatus() {
    if (user.rekening!.isNotEmpty && user.noRekening!.isNotEmpty) {
      Jump.toArg(
        Pages.sellerPage,
        {'isRegister': user.userIsSeller},
      ).then((_) => bloc(ProfilInitEvent()));
    } else {
      showDialog(
        context: context,
        builder: (context) => CustomDialogBox(
          onTapYes: () {
            Navigator.of(context).pop();
            Jump.to(Pages.editProfile).then((_) {
              bloc(ProfilInitEvent());
            });
          },
          descriptions: 'Profile need to be completed to start transaction',
          title: 'Profile Not Completed',
          yes: 'I Understand',
          no: 'Later',
        ),
      );
    }
  }
}
