import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:petani_kopi/bloc/login_bloc/login_bloc.dart';
import 'package:petani_kopi/bloc/login_bloc/login_event.dart';
import 'package:petani_kopi/bloc/register_bloc/register_bloc.dart';
import 'package:petani_kopi/bloc/register_bloc/register_event.dart';
import 'package:petani_kopi/bloc/register_bloc/register_state.dart';
import 'package:petani_kopi/bloc/login_bloc/login_state.dart';
import 'package:petani_kopi/common/common_button.dart';
import 'package:petani_kopi/common/common_shimmer.dart';
import 'package:petani_kopi/common/common_textfield.dart';
import 'package:petani_kopi/helper/constants.dart';
import 'package:petani_kopi/helper/extension.dart';
import 'package:petani_kopi/helper/page.dart';
import 'package:petani_kopi/helper/snack_bar.dart';
import 'package:petani_kopi/model/users.dart';
import 'package:petani_kopi/service/jump.dart';
import 'package:petani_kopi/theme/colors.dart';
import 'package:petani_kopi/theme/login_style.dart';

class RegisterPage extends StatelessWidget {
  final TabController tabController;
  const RegisterPage(this.tabController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
      ],
      child: RegisterBody(tabController),
    );
  }
}

class RegisterBody extends StatefulWidget {
  final TabController tabController;
  const RegisterBody(this.tabController, {Key? key}) : super(key: key);

  @override
  _RegisterBodyState createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailCo = TextEditingController();
  TextEditingController passCo = TextEditingController();
  TextEditingController noHpCo = TextEditingController();
  TextEditingController userNameCo = TextEditingController();
  TextEditingController pass2ndCo = TextEditingController();

  FocusNode emailNode = FocusNode();
  FocusNode passNode = FocusNode();
  FocusNode noHpNode = FocusNode();
  FocusNode userNameNode = FocusNode();
  FocusNode pass2ndNode = FocusNode();

  bloc(dynamic event) {
    BlocProvider.of<RegisterBloc>(context).add(event);
  }

  loginBloc(dynamic event) {
    BlocProvider.of<LoginBloc>(context).add(event);
  }

  submit() {
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      Users users = Users();
      users.userName = userNameCo.text;
      users.userMail = emailCo.text;
      users.userPhone = noHpCo.text;
      users.password = passCo.text;
      bloc(RegisterSubmit(users));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterComplete) {
              Map<String, dynamic> map = state.user.toMap();
              map[Const.pass] = state.user.password;
              map[Const.email] = state.user.userMail;
              loginBloc(LoginOnSubmit(map));
            }
            if (state is RegisterFailed) {
              context.fail(state.error);
            }
          },
        ),
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Jump.replace(Pages.homePage);
            }
            if (state is LoginFailed) {
              context.fail(state.error);
            }
          },
        ),
      ],
      child: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.only(left: 36, right: 36, top: 24),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextfield(
                  node: emailNode,
                  controller: emailCo,
                  hint: 'Email',
                  prefixIcon: IconlyLight.edit,
                  validator: (val) => emailValidate(val),
                  onSubmit: (_) => context.nextFocus(userNameNode),
                ),
                const SizedBox(height: 20),
                CommonTextfield(
                  node: userNameNode,
                  controller: userNameCo,
                  hint: 'Username',
                  prefixIcon: IconlyLight.profile,
                  validator: (val) => nickValidate(val),
                  onSubmit: (_) => context.nextFocus(passNode),
                ),
                const SizedBox(height: 20),
                CommonTextfield(
                  node: noHpNode,
                  controller: noHpCo,
                  hint: 'No.handphone',
                  prefixIcon: Icons.phone_android_rounded,
                  validator: (val) => noHpValidate(val),
                  onSubmit: (_) => context.nextFocus(passNode),
                ),
                const SizedBox(height: 20),
                CommonTextPass(
                  node: passNode,
                  controller: passCo,
                  hint: 'Password',
                  prefixIcon: IconlyLight.lock,
                  validator: (val) => passValidate(val),
                  onSubmit: (_) => context.nextFocus(pass2ndNode),
                ),
                const SizedBox(height: 20),
                CommonTextPass(
                  node: pass2ndNode,
                  controller: pass2ndCo,
                  hint: 'Confirm password',
                  prefixIcon: IconlyLight.lock,
                  validator: (val) => secondPassValidate(val),
                ),
                const SizedBox(height: 35),
                buildButton(),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an Account ?',
                        style: loginTextStyle(),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () => widget.tabController.animateTo(0),
                        child: const Text(
                          'Sign IN',
                          style: TextStyle(
                            fontSize: 15,
                            color: mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton() => BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, regState) {
          return BlocBuilder<LoginBloc, LoginState>(
            builder: (context, logState) => CommonShimmer(
              isLoading: (regState is RegisterOnLoading ||
                  logState is LoginOnProgress),
              child: ButtonConfirmGradient(
                text: 'SIGN UP',
                onTap: () => submit(),
              ),
            ),
          );
        },
      );

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

  String? secondPassValidate(String? val) {
    if (val!.isEmpty) {
      return 'Confirmation password cant be empty';
    } else if (passCo.text != pass2ndCo.text) {
      return "Wrong confirmation password";
    } else {
      return null;
    }
  }

  String? nickValidate(String? val) {
    if (val!.isEmpty) {
      return 'Username cant be empty';
    } else {
      return null;
    }
  }

  String? noHpValidate(String? val) {
    if (val!.isEmpty) {
      return 'No.Handphone cant be empty';
    } else {
      return null;
    }
  }
}
