import 'package:flutter/material.dart';

class CommonTabButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  const CommonTabButton({
    Key? key,
    required this.text,
    required this.color,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Material(
        elevation: 10,
        color: color,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: textColor)),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
