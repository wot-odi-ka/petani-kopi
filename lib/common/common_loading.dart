import 'package:flutter/material.dart';
import 'package:petani_kopi/theme/colors.dart';

class CommonLoading extends StatelessWidget {
  final Color color;
  const CommonLoading({
    Key? key,
    this.color = mainColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 3.5,
        valueColor: AlwaysStoppedAnimation(color),
      ),
    );
  }
}
