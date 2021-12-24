import 'dart:ui';
import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback continueCallBack;
  final TextStyle textStyle;
  const LogoutDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.continueCallBack,
    this.textStyle = const TextStyle(color: Colors.black),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: Text(
            title,
            style: textStyle,
          ),
          content: Text(
            content,
            style: textStyle,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                continueCallBack();
              },
            ),
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}
