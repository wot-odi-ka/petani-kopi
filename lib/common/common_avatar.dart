import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class CommonAvatar extends StatelessWidget {
  final String imageUrl;
  final String hash;
  final double radius;
  const CommonAvatar({
    Key? key,
    required this.imageUrl,
    required this.hash,
    this.radius = 28,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.transparent,
        child: BlurHash(
          color: Colors.transparent,
          image: imageUrl,
          hash: hash,
        ),
      ),
    );
  }
}
