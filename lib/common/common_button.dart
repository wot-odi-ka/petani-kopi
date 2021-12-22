import 'package:flutter/material.dart';
import 'package:petani_kopi/helper/app_scaler.dart';
import 'package:petani_kopi/theme/colors.dart';

class ButtonConfirm extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final double? width;
  final double? fontSize;
  const ButtonConfirm({
    Key? key,
    required this.text,
    this.onTap,
    this.width,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? context.width(),
      child: ButtonTheme(
        child: TextButton(
          onPressed: onTap,
          style: confirmStyle(onTap != null),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize ?? 14,
                color: onTap != null ? projectWhite : backgroundColor,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonCancel extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final double? width;
  final double? fontSize;
  const ButtonCancel({
    Key? key,
    this.onTap,
    required this.text,
    this.width,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? context.width(),
      child: ButtonTheme(
        child: TextButton(
          onPressed: onTap,
          style: cancelStyle(onTap != null),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize ?? 14,
                color: onTap != null ? projectPrimary : backgroundColor,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }
}

ButtonStyle confirmStyle(bool? isNull) {
  return TextButton.styleFrom(
    primary: projectWhite,
    minimumSize: const Size(88, 44),
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    shape: RoundedRectangleBorder(
        side: BorderSide(
          color: isNull! ? mainColor : projectDarkGray,
          width: 1.8,
        ),
        borderRadius: BorderRadius.circular(25)),
    backgroundColor: mainColor,
  );
}

ButtonStyle cancelStyle(bool? isNull) {
  return TextButton.styleFrom(
    primary: projectPrimary,
    minimumSize: const Size(88, 44),
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: isNull! ? projectPrimary : projectDarkGray,
        width: 0.8,
      ),
      borderRadius: BorderRadius.circular(25),
    ),
    backgroundColor: projectWhite,
  );
}
