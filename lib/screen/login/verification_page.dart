import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petani_kopi/bloc/auth_bloc/auth_bloc.dart';
import 'package:petani_kopi/bloc/auth_bloc/auth_event.dart';
import 'package:petani_kopi/bloc/login_bloc/login_state.dart';
import 'package:petani_kopi/common/common_alert_dialog.dart';
import 'package:petani_kopi/common/common_button.dart';
import 'package:petani_kopi/common/common_shimmer.dart';
import 'package:petani_kopi/helper/page.dart';
import 'package:petani_kopi/screen/home/home_page.dart';
import 'package:petani_kopi/service/database.dart';
import 'package:petani_kopi/service/jump.dart';
import 'package:petani_kopi/theme/colors.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailValidate = false;
  bool canReSendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailValidate = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailValidate) {
      sendEmail();
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checEmailVerify(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future checEmailVerify() async {
    FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailValidate = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailValidate) timer?.cancel();
  }

  Future sendEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canReSendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canReSendEmail = true);
    } catch (e) {
      e.toString();
    }
  }

  @override
  Widget build(BuildContext context) => isEmailValidate
      ? const HomePage()
      : Scaffold(
          backgroundColor: mainColor,
          appBar: AppBar(
            backgroundColor: mainColor,
            title: const Text('Verify Email'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(17),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'A verification email has ben send to your email',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: projectWhite),
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonCancel(
                  text: 'Resend Email',
                  fontSize: 14,
                  onTap: () => canReSendEmail ? sendEmail() : null,
                ),
                // SizedBox(
                //   height: 21,
                // ),
                // ButtonConfirmGradient(
                //   text: 'Cencel',
                //   fontSize: 15,
                //   onTap: () => FirebaseAuth.instance.signOut(),
                // )
              ],
            ),
          ),
        );
}
