import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:petani_kopi/bloc/login_bloc/login_bloc.dart';
import 'package:petani_kopi/bloc/login_bloc/login_event.dart';
import 'package:petani_kopi/bloc/login_bloc/login_state.dart';
import 'package:petani_kopi/common/common_button.dart';
import 'package:petani_kopi/common/common_shimmer.dart';
import 'package:petani_kopi/common/common_textfield.dart';
import 'package:petani_kopi/helper/constants.dart';
import 'package:petani_kopi/helper/page.dart';
import 'package:petani_kopi/helper/snack_bar.dart';
import 'package:petani_kopi/service/jump.dart';
import 'package:petani_kopi/theme/colors.dart';
import 'package:petani_kopi/theme/login_style.dart';

class LoginPage extends StatelessWidget {
  final TabController tabController;
  const LoginPage(this.tabController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: LoginBody(tabController),
    );
  }
}

class LoginBody extends StatefulWidget {
  final TabController tabController;
  const LoginBody(this.tabController, {Key? key}) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  TextEditingController emailCo = TextEditingController();
  TextEditingController passCo = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bloc(dynamic event) {
    BlocProvider.of<LoginBloc>(context).add(event);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Jump.replace(Pages.homePage);
        }
        if (state is LoginFailed) {
          String a = 'Wrong password, please check again';
          context.fail(
            state.error == 'ERROR_WRONG_PASSWORD' ? a : state.error,
          );
        }
      },
      child: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.only(left: 36, right: 36, top: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonTextfield(
                  controller: emailCo,
                  hint: 'Email',
                  prefixIcon: IconlyLight.edit,
                  validator: (val) => emailValidate(val),
                ),
                const SizedBox(height: 20),
                CommonTextPass(
                  controller: passCo,
                  hint: 'Password',
                  prefixIcon: IconlyLight.lock,
                  validator: (val) => passValidate(val),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Forgot Password?', style: loginTextStyle()),
                  ],
                ),
                const SizedBox(height: 30),
                buildButton(),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(top: 15, bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an Account ?',
                        style: loginTextStyle(),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () => widget.tabController.animateTo(1),
                        child: const Text(
                          'Sign UP',
                          style: TextStyle(
                            fontSize: 15,
                            color: mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton() => BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return CommonShimmer(
            isLoading: state is LoginOnProgress,
            child: ButtonConfirm(
              text: 'LOGIN',
              onTap: () => login(),
            ),
          );
        },
      );

  login() {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> map = {};
      FocusScope.of(context).unfocus();
      map[Const.email] = emailCo.text.trim();
      map[Const.pass] = passCo.text.trim();
      bloc(LoginOnSubmit(map));
    }
  }

  String? emailValidate(String? val) {
    if (val!.isEmpty) {
      return 'Email cant be empty';
    } else if (!Const.loginRegex.hasMatch(val)) {
      return 'Enter correct email';
    } else {
      return null;
    }
  }

  String? passValidate(String? val) {
    if (val!.isEmpty) {
      return 'Password cant be empty';
    } else if (val.length < 6) {
      return "Enter Password 6+ characters";
    } else {
      return null;
    }
  }
}
