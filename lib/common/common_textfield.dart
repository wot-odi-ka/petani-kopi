import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:petani_kopi/theme/colors.dart';

class CommonTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String?)? validator;
  final Function(String?)? onSubmit;
  final IconData prefixIcon;
  final String hint;
  final FocusNode? node;
  const CommonTextfield({
    Key? key,
    this.controller,
    this.validator,
    this.prefixIcon = Icons.mail,
    this.hint = '',
    this.onSubmit,
    this.node,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: node ?? FocusNode(),
      controller: controller ?? TextEditingController(),
      cursorColor: mainColor,
      validator: (val) => validator!(val),
      onFieldSubmitted: (_) => onSubmit!(_),
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon, color: mainColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainColor.withOpacity(0.3)),
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainColor.withOpacity(0.3)),
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainColor.withOpacity(0.3)),
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainColor.withOpacity(0.3)),
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        ),
        contentPadding: const EdgeInsets.all(10),
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: iconColor,
        ),
      ),
    );
  }
}

class CommonTextPass extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String?)? validator;
  final IconData prefixIcon;
  final String hint;
  final FocusNode? node;
  final Function(String?)? onSubmit;
  const CommonTextPass({
    Key? key,
    this.controller,
    this.validator,
    this.prefixIcon = Icons.mail,
    this.hint = '',
    this.node,
    this.onSubmit,
  }) : super(key: key);

  @override
  State<CommonTextPass> createState() => _CommonTextPassState();
}

class _CommonTextPassState extends State<CommonTextPass> {
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.node ?? FocusNode(),
      controller: widget.controller ?? TextEditingController(),
      cursorColor: mainColor,
      obscureText: obscure,
      validator: (val) => widget.validator!(val),
      onFieldSubmitted: (_) => widget.onSubmit!(_),
      decoration: InputDecoration(
        prefixIcon: Icon(widget.prefixIcon, color: mainColor),
        suffixIcon: IconButton(
          onPressed: () => setState(() => obscure = !obscure),
          icon: Container(
            padding: const EdgeInsets.all(5),
            child: Icon(
              (obscure) ? IconlyLight.show : IconlyLight.hide,
              color: mainColor,
            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainColor.withOpacity(0.3)),
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainColor.withOpacity(0.3)),
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainColor.withOpacity(0.3)),
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainColor.withOpacity(0.3)),
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        ),
        contentPadding: const EdgeInsets.all(10),
        hintText: widget.hint,
        hintStyle: const TextStyle(fontSize: 14, color: iconColor),
      ),
    );
  }
}

class CommonSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final IconData prefixIcon;
  final String hint;
  final Function(String?)? onChange;
  const CommonSearchField({
    Key? key,
    this.controller,
    this.prefixIcon = IconlyLight.search,
    this.hint = '',
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller ?? TextEditingController(),
      cursorColor: mainColor,
      onChanged: (val) => onChange!(val) ?? (val) {},
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon, color: mainColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainColor.withOpacity(0.3)),
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainColor.withOpacity(0.3)),
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainColor.withOpacity(0.3)),
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: mainColor.withOpacity(0.3)),
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        ),
        contentPadding: const EdgeInsets.all(10),
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: iconColor,
        ),
      ),
    );
  }
}
