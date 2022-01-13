import 'package:flutter/material.dart';
import 'package:petani_kopi/model/key_val.dart';
import 'package:petani_kopi/theme/colors.dart';

class CustomDropDownBold extends StatefulWidget {
  final EdgeInsetsGeometry? margin;
  final String varSelected;
  final String? Function(String?)? onChange, validator;
  final List<KeyVal> list;
  final String hint;
  final bool isExpanded;
  final bool? readOnly;
  final bool? enabled;
  final FocusNode? focusNode;
  final Color borderColor;

  const CustomDropDownBold({
    Key? key,
    required this.varSelected,
    required this.list,
    required this.hint,
    this.isExpanded = true,
    this.margin,
    this.onChange,
    this.validator,
    this.readOnly,
    this.enabled,
    this.focusNode,
    this.borderColor = Colors.grey,
  }) : super(key: key);

  @override
  _CustomDropDownBoldState createState() => _CustomDropDownBoldState();
}

class _CustomDropDownBoldState extends State<CustomDropDownBold> {
  bool isFocus = false;
  bool readOnly = false;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<String>(
        focusNode: widget.focusNode,
        iconEnabledColor: projectWhite,
        iconDisabledColor: Colors.grey,
        style: const TextStyle(
          color: dashboardColor,
          fontSize: 14,
        ),
        validator: widget.validator,
        value: widget.varSelected,
        isExpanded: widget.isExpanded,
        items: (widget.list.isNotEmpty)
            ? widget.list.map((e) {
                return DropdownMenuItem(
                  child: Text(e.label!),
                  value: e.value,
                );
              }).toList()
            : [
                const DropdownMenuItem(
                  child: Text('Pilih'),
                  value: 'value',
                )
              ],
        onChanged: widget.onChange,
        decoration: InputDecoration(
          enabled: widget.enabled ?? true,
          labelText: widget.hint,
          labelStyle: const TextStyle(
            fontSize: 15,
            color: dashboardColor,
          ),
          filled: true,
          fillColor: fieldColor,
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
      ),
    );
  }
}
