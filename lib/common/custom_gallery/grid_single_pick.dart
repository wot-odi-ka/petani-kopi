import 'package:flutter/material.dart';
import 'package:petani_kopi/theme/colors.dart';
import 'package:petani_kopi/theme/matrix_color.dart';

class GridSinglePick extends StatelessWidget {
  final Widget? child;
  final bool? isSelected;
  const GridSinglePick({
    Key? key,
    this.child,
    this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: EdgeInsets.all(isSelected! ? 10 : 0),
      duration: const Duration(milliseconds: 200),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.matrix(
                isSelected! ? MatrixColor.selectedFilter : MatrixColor.nofilter,
              ),
              child: child,
            ),
          ),
          isSelected!
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: mainColor,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(4.0),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
