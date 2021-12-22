import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:petani_kopi/theme/colors.dart';

class CommonDetailAnimation extends StatelessWidget {
  final Widget detail;
  final Widget child;
  final Color color;
  const CommonDetailAnimation({
    Key? key,
    required this.detail,
    required this.child,
    this.color = backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedColor: color,
      closedElevation: 0,
      transitionType: ContainerTransitionType.fade,
      openBuilder: (BuildContext context, VoidCallback _) {
        return detail;
      },
      closedBuilder: (BuildContext context, VoidCallback _) {
        return child;
      },
    );
  }
}

class DetailUserImage extends StatelessWidget {
  final String imageUrl;
  final String imageHash;
  const DetailUserImage({
    Key? key,
    required this.imageUrl,
    required this.imageHash,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: BlurHash(
            hash: imageHash,
            image: imageUrl,
            imageFit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
