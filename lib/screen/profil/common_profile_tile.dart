import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:petani_kopi/screen/profil/common_profile_textfield.dart';
import 'package:petani_kopi/theme/colors.dart';

class CommonProfileTile extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? node;
  final String text;
  final bool enableEdit;
  final bool onEdit;
  final Function()? onTapEdit;
  final Function()? onClosed;
  const CommonProfileTile({
    Key? key,
    this.text = '',
    this.enableEdit = true,
    this.controller,
    this.node,
    this.onTapEdit,
    this.onEdit = false,
    this.onClosed,
  }) : super(key: key);

  @override
  State<CommonProfileTile> createState() => _CommonProfileTileState();
}

class _CommonProfileTileState extends State<CommonProfileTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16, right: 0.0),
      // leading: Icon(widget.icon, color: mainColor),
      title: animatedTitle(),
      trailing: Visibility(
        visible: widget.enableEdit,
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: 50,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(15),
                  ),
                  child: InkWell(
                    onTap: widget.onTapEdit ?? () {},
                    child: const Icon(
                      Icons.edit,
                      color: mainColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  animatedTitle() => AnimatedSwitcher(
        duration: const Duration(milliseconds: 100),
        child: (widget.onEdit)
            ? CommonProfileTextfield(
                key: const ValueKey(1),
                controller: widget.controller,
                node: widget.node,
                onSubmit: (val) {},
                onClosed: () => widget.onClosed!(),
              )
            : Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.text,
                  style: const TextStyle(color: mainColor),
                  key: const ValueKey(2),
                ),
              ),
      );
}
