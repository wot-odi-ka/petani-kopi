import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:petani_kopi/theme/matrix_color.dart';

class GridVideoPick extends StatelessWidget {
  final Widget? child;
  final bool? isSelected;
  final String? duration;

  const GridVideoPick({
    Key? key,
    this.child,
    this.isSelected,
    this.duration,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: ClipRRect(
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                      child: Text(
                        duration!,
                        style: const TextStyle(color: Colors.white),
                      )),
                ),
              ),
            ),
          ),
          isSelected!
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xff2DB6BB),
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
