import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:petani_kopi/common/ahead_dropdown.dart';
import 'package:petani_kopi/common/shared_profile_field.dart';
import 'package:petani_kopi/helper/constants.dart';
import 'package:petani_kopi/theme/colors.dart';

class TileType {
  static const normal = 'normal';
  static const drop = '';
}

class CommonProfileTileField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String tileType;
  final List<String> items;
  final TextInputType textInputType;
  final FocusNode? node;
  final IconData icon;
  const CommonProfileTileField({
    Key? key,
    required this.controller,
    this.hint = '',
    this.tileType = TileType.normal,
    this.items = Const.city,
    this.textInputType = TextInputType.text,
    this.icon = IconlyLight.arrow_right_2,
    this.node,
  }) : super(key: key);

  @override
  _CommonProfileTileFieldState createState() => _CommonProfileTileFieldState();
}

class _CommonProfileTileFieldState extends State<CommonProfileTileField> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: (widget.tileType == TileType.normal)
                    ? CommonProductField(
                        node: widget.node,
                        hint: widget.hint,
                        controller: widget.controller,
                        textInputType: widget.textInputType,
                        onChange: (v) => setState(() {}),
                      )
                    : AheadDropdown(
                        node: widget.node,
                        controller: widget.controller,
                        items: widget.items,
                        hint: widget.hint,
                        onSubmit: (v) => setState(() {}),
                      ),
                trailing: Icon(
                  widget.icon,
                  color: mainColor,
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: widget.controller.text.isNotEmpty && widget.hint.isNotEmpty,
          child: Positioned(
            top: -7,
            left: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                boxShadow: commonShadow,
                color: projectWhite,
                borderRadius: const BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              child: Text(
                widget.hint,
                style: const TextStyle(
                  color: mainColor,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
