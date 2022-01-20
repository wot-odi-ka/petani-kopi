import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:petani_kopi/screen/login/login_main.dart';

import 'database.dart';

class Auth {
  static signInWithEmail({required String mail, required String pass}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential result = await auth
        .signInWithEmailAndPassword(
          email: mail,
          password: pass,
        )
        .catchError((e) => throw e);
    return result.user!.uid;
  }

  static signUpWithEmail(String mail, String pass) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential result = await auth
        .createUserWithEmailAndPassword(
          email: mail,
          password: pass,
        )
        .catchError((e) => throw e);
    return result.user!.uid;
  }

  static resetPass({required String email}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      return await auth
          .sendPasswordResetEmail(email: email)
          .then((value) => const LoginMainPage());
    } catch (e) {
      rethrow;
    }
  }

  static signOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await DB.clear();
      await auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
