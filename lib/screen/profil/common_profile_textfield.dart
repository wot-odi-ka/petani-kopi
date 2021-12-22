import 'package:flutter/material.dart';
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
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: const TextStyle(
          color: backgroundColor,
          fontWeight: FontWeight.w300,
          fontSize: 22,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: backgroundColor),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: backgroundColor),
        ),
      ),
      onFieldSubmitted: (val) => widget.onSubmit!(val),
    );
  }
}
