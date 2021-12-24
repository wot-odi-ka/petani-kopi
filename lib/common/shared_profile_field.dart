import 'package:flutter/material.dart';
import 'package:petani_kopi/theme/colors.dart';

class SharedProfileField extends StatelessWidget {
  final FocusNode? node;
  final TextEditingController? controller;
  final String hint;
  final String title;
  final Function(String)? onSubmit;
  final Function()? onClosed;
  final Widget? suffixIcon;
  const SharedProfileField({
    Key? key,
    this.node,
    this.controller,
    this.hint = '',
    this.title = '',
    this.onSubmit,
    this.onClosed,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 4),
          child: (title.isNotEmpty)
              ? Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                  ),
                )
              : const SizedBox(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: TextFormField(
            cursorColor: mainColor,
            controller: controller ?? TextEditingController(),
            focusNode: node ?? FocusNode(),
            style: const TextStyle(color: mainColor),
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              hintText: hint,
              hintStyle: const TextStyle(
                color: backgroundColor,
                fontWeight: FontWeight.w300,
                fontSize: 22,
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: mainColor,
                  width: 0.5,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: mainColor,
                  width: 0.5,
                ),
              ),
            ),
            onFieldSubmitted: (val) => onSubmit!(val),
          ),
        ),
      ],
    );
  }
}

class CommonProductField extends StatelessWidget {
  final FocusNode? node;
  final TextEditingController? controller;
  final String hint;
  final String title;
  final Function(String)? onSubmit;
  final Function()? onClosed;
  final Function(String?)? onChange;
  final Widget? suffixIcon;
  final TextInputType textInputType;
  const CommonProductField({
    Key? key,
    this.node,
    this.controller,
    this.hint = '',
    this.title = '',
    this.textInputType = TextInputType.text,
    this.onSubmit,
    this.onClosed,
    this.suffixIcon,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: mainColor,
      controller: controller ?? TextEditingController(),
      focusNode: node ?? FocusNode(),
      style: const TextStyle(color: mainColor),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hint,
        isDense: true,
        hintStyle: const TextStyle(
          color: mainColor,
          fontWeight: FontWeight.w300,
          fontSize: 14,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: mainColor,
            width: 0.5,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: mainColor,
            width: 0.5,
          ),
        ),
      ),
      onChanged: onChange,
      textInputAction: TextInputAction.done,
      keyboardType: textInputType,
    );
  }
}
