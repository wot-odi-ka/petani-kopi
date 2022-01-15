import 'package:flutter/material.dart';

class Const {
  static const String email = 'email';
  static const String pass = 'pass';

  static const String typeNormal = 'normal';
  static const String typeImage = 'image';

  static const notConfirmed = 'STATUS_NOT_CONFIRMED';
  static const confirmed = 'STATUS_CONFIRMED';
  static const packaging = 'STATUS_PACKAGING';
  static const send = 'STATUS_SEND';
  static const done = 'STATUS_DONE';

  static const orderIncoming = 'ORDER_INCOMING';
  static const orderOutcoming = 'ORDER_OUTCOMING';

  //default
  static const String aboutMe = 'masukan Alamat anda';
  static const String fb = 'defaultfblogin';
  static const String google = 'defaultgooglelogin';
  static const String emptyHash = "A0Ih]g%M00Rk";
  // static const String emptyImage =
  //     'https://firebasestorage.googleapis.com/v0/b/com-id-retalk.appspot.com/o/no_image.png?alt=media&token=43d2ea29-0d1d-4b1a-89cb-50189861ca4e';

  static const String emptyImage =
      'https://firebasestorage.googleapis.com/v0/b/petani-kopi.appspot.com/o/empty-img.png?alt=media&token=2cf2e116-9e0d-48f2-8e83-301f3eb26ab0';

  static RegExp loginRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  static const List<String> city = [
    'Jakarta',
    'Bekasi',
    'Depok',
    'Bogor',
    'Tangerang',
    'Bandung',
    'Sukabumi'
  ];

  static const List<String> rekening = [
    'BCA',
    'BNI',
    'Bank DKI',
    'Mandiri',
    'BRI',
  ];

  static const List<String> cofeeType = [
    'Americano',
    'Latte',
    'Cappuccino',
    'Flat White',
    'Es Kopi Susu',
    'Cafe Au Lait',
    'Black Coffee',
    'Espresso',
    'Macchiato',
    'Cold Brew',
  ];

  static const List<String> cofeeTypeBar = [
    'All',
    'Americano',
    'Latte',
    'Cappuccino',
    'Flat White',
    'Es Kopi Susu',
    'Cafe Au Lait',
    'Black Coffee',
    'Espresso',
    'Macchiato',
    // 'Cold Brew',
  ];

  static const SliverGridDelegateWithFixedCrossAxisCount fixGrid =
      SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 10,
    crossAxisSpacing: 25,
  );
}

List<BoxShadow> commonShadow = [
  BoxShadow(
    color: Colors.grey.shade200.withOpacity(0.8),
    spreadRadius: 2,
    blurRadius: 7,
    offset: const Offset(5, 5),
  )
];
