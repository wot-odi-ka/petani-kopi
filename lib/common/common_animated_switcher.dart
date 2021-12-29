import 'package:flutter/material.dart';

class CommonAnimatedSwitcher extends StatelessWidget {
  final bool status;
  final Widget trueWidget;
  final Widget falseWidget;
  final int animationDuration;
  const CommonAnimatedSwitcher({
    Key? key,
    required this.status,
    required this.trueWidget,
    required this.falseWidget,
    this.animationDuration = 350,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: animationDuration),
      switchOutCurve: const Threshold(1),
      child: switchs(),
    );
  }

  Widget switchs() {
    if (status) {
      return SizedBox(
        key: const ValueKey(0),
        child: trueWidget,
      );
    } else {
      return SizedBox(
        key: const ValueKey(1),
        child: falseWidget,
      );
    }
  }
}
