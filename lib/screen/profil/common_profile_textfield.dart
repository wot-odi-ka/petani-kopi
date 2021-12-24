import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:petani_kopi/theme/colors.dart';

class CommonProfileTextfield extends StatefulWidget {
  final FocusNode? node;
  final TextEditingController? controller;
  final String hint;
  final Function(String)? onSubmit;
  final Function()? onClosed;
  const CommonProfileTextfield({
    Key? key,
    this.node,
    this.controller,
    this.hint = '',
    this.onSubmit,
    this.onClosed,
  }) : super(key: key);

  @override
  State<CommonProfileTextfield> createState() => _CommonProfileTextfieldState();
}

class _CommonProfileTextfieldState extends State<CommonProfileTextfield>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final value = WidgetsBinding.instance!.window.viewInsets.bottom;
    if (value == 0) {
      widget.node!.unfocus();
      widget.onClosed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: mainColor,
      controller: widget.controller ?? TextEditingController(),
      focusNode: widget.node ?? FocusNode(),
      style: const TextStyle(
        color: mainColor,
        // fontWeight: FontWeight.w300,
        // fontSize: 22,
      ),
      decoration: decor(IconlyLight.edit),

      // InputDecoration(
      //   hintText: widget.hint,
      //   fillColor: projectWhite,
      //   hintStyle: const TextStyle(
      //     color: backgroundColor,
      //     fontWeight: FontWeight.w300,
      //     fontSize: 22,
      //   ),
      //   enabledBorder: const UnderlineInputBorder(
      //     borderSide: BorderSide(color: backgroundColor),
      //   ),
      //   focusedBorder: const UnderlineInputBorder(
      //     borderSide: BorderSide(color: backgroundColor),
      //   ),
      // ),
      onFieldSubmitted: (val) => widget.onSubmit!(val),
    );
  }

  InputDecoration decor(IconData prefix) {
    return InputDecoration(
      prefixIcon: Icon(prefix, color: mainColor),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: mainColor.withOpacity(0.3)),
        borderRadius: const BorderRadius.all(Radius.circular(25)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: mainColor.withOpacity(0.3)),
        borderRadius: const BorderRadius.all(Radius.circular(25)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: mainColor.withOpacity(0.3)),
        borderRadius: const BorderRadius.all(Radius.circular(25)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: mainColor.withOpacity(0.3)),
        borderRadius: const BorderRadius.all(Radius.circular(25)),
      ),
      contentPadding: const EdgeInsets.all(10),
      hintText: 'hint',
      hintStyle: const TextStyle(
        fontSize: 14,
        color: iconColor,
      ),
    );
  }
}
