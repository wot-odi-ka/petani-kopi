import 'package:flutter/material.dart';

class MyTheme {
  MyTheme._();
  static const Color kPrimaryColor = Color(0xff7C7B9B);
  static const Color kPrimaryColorVariant = Color(0xff686795);
  static const Color kAccentColor = Color(0xffFCAAAB);
  static const Color kAccentColorVariant = Color(0xffF7A3A2);
  static const Color kUnreadChatBG = Color(0xffEE1D1D);

  static const TextStyle heading2 = TextStyle(
    color: Colors.brown,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
  );

  static const TextStyle chatSenderName = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w300,
    letterSpacing: 1.5,
  );

  static const TextStyle chatSenderNames = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w300,
    letterSpacing: 1.5,
  );

  static const TextStyle chatSenderNames2 = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.5,
  );

  static const TextStyle chatSenderNames3 = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.5,
  );

  static const TextStyle bodyText1 = TextStyle(
      color: Color(0xffAEABC9),
      fontSize: 14,
      letterSpacing: 1.2,
      fontWeight: FontWeight.w500);

  static const TextStyle bodyTextMessage =
      TextStyle(fontSize: 13, letterSpacing: 1.5, fontWeight: FontWeight.w600);

  static const TextStyle bodyTextTime = TextStyle(
    color: Color(0xffAEABC9),
    fontSize: 11,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
  );
}
