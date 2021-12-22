import 'package:flutter/material.dart';
import 'package:petani_kopi/theme/colors.dart';

class CommonLoading extends StatelessWidget {
  const CommonLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 3.5,
        valueColor: AlwaysStoppedAnimation(mainColor),
      ),
    );
  }
}
