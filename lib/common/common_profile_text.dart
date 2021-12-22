import 'package:flutter/material.dart';
import 'package:petani_kopi/theme/colors.dart';

class CommonProfileText extends StatelessWidget {
  final String text;
  const CommonProfileText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: mainColor,
        ),
      ),
    );
  }
}
