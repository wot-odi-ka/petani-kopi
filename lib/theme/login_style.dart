import 'package:flutter/material.dart';
import 'package:petani_kopi/theme/colors.dart';

TextSpan signInSPan() => const TextSpan(
      text: "Welcome",
      style: TextStyle(
        fontSize: 25,
        letterSpacing: 2,
        color: backgroundColor,
      ),
      children: [
        TextSpan(
          text: ' Back',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: backgroundColor,
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
        color: backgroundColor,
      ),
      children: [
        TextSpan(
          text: ' Petani Kopi',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: backgroundColor,
            fontStyle: FontStyle.italic,
          ),
        )
      ],
    );

TextStyle loginTextStyle() => const TextStyle(
      fontSize: 15,
      color: mainColor,
      fontWeight: FontWeight.w600,
    );
