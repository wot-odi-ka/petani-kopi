import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:petani_kopi/service/jump.dart';
import 'package:petani_kopi/theme/colors.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, yes, no;
  final IconData icon;
  final Function() onTapYes;
  const CustomDialogBox({
    Key? key,
    required this.onTapYes,
    this.title = 'Default',
    this.descriptions = 'Default',
    this.yes = 'Yes',
    this.no = 'No',
    this.icon = Icons.info,
  }) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: contentBox(context),
      ),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            left: 20,
            top: 65,
            right: 20,
            bottom: 20,
          ),
          margin: const EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0, 10),
                  blurRadius: 10,
                ),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                widget.descriptions,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 22),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => widget.onTapYes(),
                      child: Text(
                        widget.yes,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Jump.back(),
                      child: Text(
                        widget.no,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor:
                (widget.icon == Icons.info) ? projectWarning : projectGreen,
            radius: 45,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(45),
              ),
              child: Icon(
                widget.icon,
                color: backgroundColor,
                size: 38,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

extension ShowAlertDialog on BuildContext {
  showAlertDialog({
    required Function() onTapYes,
    required String description,
    required String title,
    required String yesText,
    required String cancelText,
  }) {
    return showDialog(
      context: this,
      builder: (context) => CustomDialogBox(
        onTapYes: () => onTapYes(),
        descriptions: description,
        title: title,
        yes: yesText,
        no: cancelText,
      ),
    );
  }
}
