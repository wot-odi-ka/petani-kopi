import 'package:flutter/material.dart';
import 'package:petani_kopi/theme/matrix_color.dart';

class GridItem extends StatefulWidget {
  final Function(bool)? isSelected;
  final bool? check;
  final Widget? child;

  const GridItem({
    Key? key,
    this.isSelected,
    this.check,
    this.child,
  }) : super(key: key);

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    if (widget.check != null && widget.check!) {
      isSelected = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.isSelected!(isSelected);
        });
      },
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(isSelected ? 10 : 0),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: ColorFiltered(
                colorFilter: ColorFilter.matrix(
                  isSelected
                      ? MatrixColor.selectedFilter
                      : MatrixColor.nofilter,
                ),
                child: widget.child,
              ),
            ),
            isSelected
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
      ),
    );
  }
}
