import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:petani_kopi/common/shared_profile_field.dart';
import 'package:petani_kopi/service/jump.dart';
import 'package:petani_kopi/theme/colors.dart';

class ChangeProfileDialog extends StatefulWidget {
  final Function(String?) onSave;
  final String title;
  final String value;
  const ChangeProfileDialog({
    Key? key,
    required this.onSave,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  _ChangeProfileDialogState createState() => _ChangeProfileDialogState();
}

class _ChangeProfileDialogState extends State<ChangeProfileDialog> {
  TextEditingController textCo = TextEditingController();
  FocusNode node = FocusNode();

  @override
  void initState() {
    textCo.text = widget.value;
    node.requestFocus();
    WidgetsBinding.instance!.addPostFrameCallback((_) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: Material(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: widget.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            color: mainColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      titleIcon(),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: SharedProfileField(
                        controller: textCo,
                        node: node,
                        hint: widget.title,
                        suffixIcon: const Icon(
                          Icons.edit,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Jump.back(),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: mainColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    TextButton(
                      onPressed: () => widget.onSave(textCo.text),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: mainColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget titleIcon() {
    if (widget.title == 'Username') {
      return const Icon(IconlyBold.profile);
    } else if (widget.title == 'Phone Number') {
      return const Icon(
        IconlyBold.call,
      );
    } else {
      return const Icon(
        IconlyBold.location,
      );
    }
  }
}
