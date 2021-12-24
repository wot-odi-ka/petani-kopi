import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petani_kopi/bloc/auth_bloc/auth_bloc.dart';
import 'package:petani_kopi/bloc/auth_bloc/auth_event.dart';
import 'package:petani_kopi/bloc/auth_bloc/auth_state.dart';
import 'package:petani_kopi/common/keep_alive.dart';
import 'package:petani_kopi/helper/app_scaler.dart';
import 'package:petani_kopi/helper/page.dart';
import 'package:petani_kopi/helper/snack_bar.dart';
import 'package:petani_kopi/screen/login/login_screen.dart';
import 'package:petani_kopi/screen/login/register_page.dart';
import 'package:petani_kopi/service/jump.dart';
import 'package:petani_kopi/theme/colors.dart';
import 'package:petani_kopi/theme/gradient_colors.dart';
import 'package:petani_kopi/theme/login_style.dart';

class LoginMainPage extends StatelessWidget {
  const LoginMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc()..add(InitAuthEvent()),
      child: const LoginMainBody(),
    );
  }
}

class LoginMainBody extends StatefulWidget {
  const LoginMainBody({Key? key}) : super(key: key);

  @override
  _LoginMainBodyState createState() => _LoginMainBodyState();
}

class _LoginMainBodyState extends State<LoginMainBody>
    with TickerProviderStateMixin {
  late TabController tabController;
  int selectedIndex = 1;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    tabController.addListener(onChangeIndex);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  onChangeIndex() {
    if (tabController.indexIsChanging) {
      selectedIndex = tabController.index;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is IsLoggedIn) {
          Jump.replace(Pages.homePage);
        }
        if (state is AuthFailed) {
          context.fail(state.error);
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          backgroundColor: Colors.grey[900]!,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4),
                  BlendMode.colorBurn,
                ),
                child: Container(
                  width: context.width(),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/kopiHitam.png'),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      colors: GradientColors.blackGray,
                    ),
                  ),
                  padding: const EdgeInsets.only(bottom: 100.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 100),
                      BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 3.0,
                          sigmaY: 3.0,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 40.0),
                                child: RichText(
                                  text: selectedIndex == 0
                                      ? signInSPan()
                                      : signUpSpan(),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(left: 55.0),
                                child: Text(
                                  selectedIndex == 0
                                      ? "Sign in to Continue"
                                      : "Sign up to Continue",
                                  style: const TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: context.width(),
                  decoration: const BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25),
                          ),
                        ),
                        child: TabBar(
                          controller: tabController,
                          indicatorColor: Colors.transparent,
                          unselectedLabelColor: mainColor,
                          indicator: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(25),
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: GradientColors.premiumDark,
                            ),
                          ),
                          labelColor: backgroundColor,
                          tabs: const [
                            Tab(
                              child: Center(child: Text('Sign in')),
                            ),
                            Tab(
                              child: Center(child: Text('Sign up')),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            KeepAlivePage(
                              child: LoginPage(tabController),
                            ),
                            KeepAlivePage(
                              child: RegisterPage(tabController),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
