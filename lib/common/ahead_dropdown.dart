import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:petani_kopi/theme/colors.dart';

class AheadDropdown extends StatefulWidget {
  final List<String> items;
  final FocusNode? node;
  final TextEditingController controller;
  final String hint;
  final Function(String)? onSubmit;
  final Widget? suffixIcon;
  const AheadDropdown({
    Key? key,
    required this.controller,
    required this.items,
    this.hint = 'Default',
    this.node,
    this.onSubmit,
    this.suffixIcon,
  }) : super(key: key);

  @override
  _AheadDropdownState createState() => _AheadDropdownState();
}

class _AheadDropdownState extends State<AheadDropdown> {
  SuggestionsBoxController controller = SuggestionsBoxController();
  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField<String>(
      suggestionsBoxDecoration: const SuggestionsBoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        constraints: BoxConstraints(maxHeight: 230),
        hasScrollbar: true,
      ),
      suggestionsBoxController: controller,
      hideKeyboard: true,
      textFieldConfiguration: TextFieldConfiguration(
        focusNode: widget.node,
        controller: widget.controller,
        onTap: () => controller.toggle(),
        style: const TextStyle(
          color: mainColor,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          isDense: true,
          hintText: widget.hint,
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
      ),
      loadingBuilder: (context) => const SizedBox(height: 1),
      suggestionsCallback: (pattern) {
        return widget.items;
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(
            suggestion,
            style: const TextStyle(
              color: mainColor,
              fontSize: 13,
            ),
          ),
        );
      },
      onSuggestionSelected: (suggestion) {
        widget.controller.text = suggestion;
        if (widget.onSubmit != null) {
          widget.onSubmit!(suggestion);
        }
      },
    );
  }
}
