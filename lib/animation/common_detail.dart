// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class CommonDetail extends StatelessWidget {
  final Widget item;
  final Widget page;
  const CommonDetail({
    Key? key,
    required this.item,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedColor: Colors.black.withOpacity(0.3),
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      transitionDuration: Duration(milliseconds: 500),
      transitionType: ContainerTransitionType.fade,
      closedBuilder: (BuildContext _, VoidCallback openContainer) {
        return item;
      },
      openBuilder: (BuildContext _, VoidCallback __) {
        return page;
      },
      onClosed: (_) => print('Closed'),
    );
  }
}
