// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DashboardField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final Color borderColor;
  final String hint;
  final double? height;
  final double? contentPadding;
  final bool enabled;
  final bool readOnly;
  final int? minLines;
  final int? maxLines;
  final Widget? prefixIcon;
  final FloatingLabelBehavior behavior;
  final Function(String)? onChange;
  const DashboardField({
    Key? key,
    this.controller,
    this.hint = 'Default',
    this.height = 48,
    this.borderColor = Colors.grey,
    this.validator,
    this.enabled = true,
    this.readOnly = false,
    this.minLines,
    this.maxLines,
    this.contentPadding,
    this.onTap,
    this.prefixIcon,
    this.behavior = FloatingLabelBehavior.never,
    this.onChange,
  }) : super(key: key);

  @override
  _DashboardFieldState createState() => _DashboardFieldState();
}

class _DashboardFieldState extends State<DashboardField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.white,
      controller: widget.controller ?? TextEditingController(),
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      onChanged: widget.onChange,
      style: TextStyle(
        fontSize: 15,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        isDense: true,
        floatingLabelBehavior: widget.behavior,
        contentPadding: widget.contentPadding != null
            ? EdgeInsets.only(left: widget.contentPadding!)
            : null,
        prefixIcon: widget.prefixIcon,
        label: Text(
          widget.hint,
          maxLines: 1,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        fillColor: Color(0xFF161922),
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
