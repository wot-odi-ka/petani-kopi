import 'package:flutter/material.dart';
import 'package:petani_kopi/theme/colors.dart';

class CommonProfileText extends StatelessWidget {
  final String text;
  final Color color;
  const CommonProfileText({
    Key? key,
    required this.text,
    this.color = mainColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}

class FillField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final Color borderColor;
  final Color fillColor;
  final String hint;
  final double? height;
  final double? contentPadding;
  final bool enabled;
  final bool readOnly;
  final int? minLines;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final FloatingLabelBehavior behavior;
  const FillField({
    Key? key,
    this.controller,
    this.hint = '',
    this.height = 48,
    this.borderColor = Colors.grey,
    this.fillColor = Colors.grey,
    this.validator,
    this.enabled = true,
    this.readOnly = false,
    this.minLines,
    this.maxLines,
    this.contentPadding,
    this.onTap,
    this.prefixIcon,
    this.sufixIcon,
    this.behavior = FloatingLabelBehavior.never,
  }) : super(key: key);

  @override
  _FillFieldState createState() => _FillFieldState();
}

class _FillFieldState extends State<FillField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: mainColor,
      controller: widget.controller ?? TextEditingController(),
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      style: const TextStyle(
        fontSize: 15,
        color: mainColor,
      ),
      decoration: InputDecoration(
        isDense: true,
        floatingLabelBehavior: widget.behavior,
        contentPadding: widget.contentPadding != null
            ? EdgeInsets.only(left: widget.contentPadding!)
            : null,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.sufixIcon,
        label: Visibility(
          visible: widget.hint.isNotEmpty,
          child: Container(
            decoration: const BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(8),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Text(
              widget.hint,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 18,
                color: mainColor,
              ),
            ),
          ),
        ),
        fillColor: widget.fillColor,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: widget.borderColor, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: widget.borderColor, width: 1.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: widget.borderColor, width: 1.0),
        ),
      ),
      validator: widget.validator ?? (v) {},
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      textInputAction: TextInputAction.search,
    );
  }
}
