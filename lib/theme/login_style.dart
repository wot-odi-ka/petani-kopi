import 'package:flutter/material.dart';
import 'package:petani_kopi/theme/colors.dart';

TextSpan signInSPan() => const TextSpan(
      text: "Welcome Back",
      style: TextStyle(
        fontSize: 25,
        letterSpacing: 2,
        color: Colors.white,
      ),
      children: [
        TextSpan(
          text: ' \n     to Petani Kopi',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        )
      ],
    );

TextSpan signUpSpan() => const TextSpan(
      text: "Welcome to",
      style: TextStyle(
        fontSize: 25,
        letterSpacing: 2,
        color: Colors.white,
      ),
      children: [
        TextSpan(
          text: ' \n      Petani Kopi',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        )
      ],
    );

TextSpan petani() => const TextSpan(
      text: ' Petani Kopi',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontStyle: FontStyle.italic,
      ),
    );

TextStyle loginTextStyle() => const TextStyle(
      fontSize: 15,
      color: mainColor,
      fontWeight: FontWeight.w600,
    );
