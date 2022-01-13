import 'package:flutter/material.dart';
import 'package:petani_kopi/theme/colors.dart';

class EmptyProducts extends StatelessWidget {
  final Function() onTap;
  final String text;
  final IconData icon;
  final Color textColor;
  final Color bodyColor;
  const EmptyProducts({
    Key? key,
    required this.onTap,
    this.text = 'Click to add Products',
    this.icon = Icons.add,
    this.textColor = backgroundColor,
    this.bodyColor = mainColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Material(
        elevation: 5,
        color: bodyColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: textColor,
                  size: 24,
                ),
                const SizedBox(height: 10),
                Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
