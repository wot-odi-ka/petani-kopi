import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
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

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: const ForgotPasswordBoddy(),
    );
  }
}

class ForgotPasswordBoddy extends StatefulWidget {
  const ForgotPasswordBoddy({Key? key}) : super(key: key);

  @override
  _ForgotPasswordBoddyState createState() => _ForgotPasswordBoddyState();
}

class _ForgotPasswordBoddyState extends State<ForgotPasswordBoddy> {
  TextEditingController emailCo = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bloc(dynamic event) {
    BlocProvider.of<LoginBloc>(context).add(event);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is ForgotPassSucsess) {
          Jump.replace(Pages.loginScreen);
        }
        if (state is LoginFailed) {
          String a = 'Wrong password, please check again';
          context.fail(
            state.error == 'ERROR_WRONG_PASSWORD' ? a : state.error,
          );
        }
      },
      child: Scaffold(
        backgroundColor: projectWhite,
        appBar: AppBar(
          backgroundColor: mainColor,
          title: const Text('Reset Your Password'),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Input your email',
                  style: TextStyle(
                    fontSize: 30,
                    color: mainColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                CommonTextfieldForgotPass(
                  controller: emailCo,
                  hint: 'Email',
                  prefixIcon: IconlyLight.edit,
                  validator: (val) => emailValidate(val),
                ),
                const SizedBox(height: 20),
                buildButton(),
                const SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  child: const Text('Sign In'),
                  onTap: () {
                    Jump.to(Pages.loginScreen);
                  },
                )
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
            isLoading: state is ForgotPassOnProcess,
            child: ButtonConfirmGradient(
              text: 'Send email',
              onTap: () => login(),
              fontSize: 14,
            ),
          );
        },
      );

  login() {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> map = {};
      FocusScope.of(context).unfocus();
      map[Const.email] = emailCo.text.trim();
      bloc(ForgotPassOnSubmit(map));
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
}
