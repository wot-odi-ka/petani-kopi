import 'package:flutter/material.dart';
import 'package:petani_kopi/theme/colors.dart';
import 'package:shimmer/shimmer.dart';

class CommonSingUp extends StatelessWidget {
  final Widget? child;
  final bool? isLoading;
  const CommonSingUp({
    Key? key,
    required this.child,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 5),
      child: (isLoading!)
          ? Shimmer.fromColors(
              key: const ValueKey('1'),
              period: const Duration(milliseconds: 300),
              baseColor: iconColor.withOpacity(0.8),
              highlightColor: Colors.grey.shade100,
              child: child!,
            )
          : child!,
    );
  }
}
