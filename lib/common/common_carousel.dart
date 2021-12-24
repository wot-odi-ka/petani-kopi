import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petani_kopi/helper/app_scaler.dart';
import 'package:petani_kopi/theme/colors.dart';

class CarouselArg {
  File? image;
  int? index;
  String? hash;
  CarouselArg({
    this.image,
    this.index,
    this.hash,
  });
}

class CommonCarousel extends StatelessWidget {
  final PageController controller;
  final AnimationController animation;
  final CarouselArg model;
  final VoidCallback onDel;
  const CommonCarousel({
    Key? key,
    required this.controller,
    required this.animation,
    required this.model,
    required this.onDel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        double value = 1.0;
        if (controller.position.haveDimensions) {
          value = controller.page! - model.index!;
          value = (1 - (value.abs() * .30)).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeOut.transform(value) * 220,
            width: context.width(),
            child: child,
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                child: Image.file(
                  model.image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 12, top: 12),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onDel,
                  child: const CircleAvatar(
                    backgroundColor: mainColor,
                    radius: 20,
                    child: Icon(
                      Icons.close_rounded,
                      color: backgroundColor,
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
}
