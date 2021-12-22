import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

String formatDuration(Duration d) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(d.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(d.inSeconds.remainder(60));
  return (d.inHours != 0)
      ? "${twoDigits(d.inHours)}:$twoDigitMinutes:$twoDigitSeconds"
      : "$twoDigitMinutes:$twoDigitSeconds";
}

class ImageClass {
  File? file;
  double? aspectRatio;

  ImageClass({this.file, this.aspectRatio});
}

class CropAspectRatios {
  /// no aspect ratio for crop
  // static const double custom = null;

  /// the same as aspect ratio of image
  /// [cropAspectRatio] is not more than 0.0, it's original
  static const double original = 0.0;

  /// ratio of width and height is 1 : 1
  static const double ratio1_1 = 1.0;

  /// ratio of width and height is 3 : 4
  static const double ratio3_4 = 3.0 / 4.0;

  /// ratio of width and height is 4 : 3
  static const double ratio4_3 = 4.0 / 3.0;

  /// ratio of width and height is 4 : 4
  static const double ratio4_4 = 4.0 / 4.0;

  /// ratio of width and height is 9 : 16
  static const double ratio9_16 = 9.0 / 16.0;

  /// ratio of width and height is 16 : 9
  static const double ratio16_9 = 16.0 / 9.0;
}

ImageClass determineRatio(int width, int height, File file) {
  double cropRatio = 0.0;
  ImageClass res = ImageClass();
  if (height >= width && height - width <= 30) {
    //Square
    cropRatio = CropAspectRatios.ratio1_1;
  } else if (width >= height && width - height <= 30) {
    //Square
    cropRatio = CropAspectRatios.ratio1_1;
  } else if (height > width) {
    //Potrait
    cropRatio = CropAspectRatios.ratio3_4;
  } else if (height < width) {
    //Landscape
    cropRatio = CropAspectRatios.ratio4_3;
  }

  res.aspectRatio = cropRatio;
  res.file = file;
  return res;
}

Future<File?> compressFile(File file) async {
  final filePath = file.absolute.path;
  final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
  final splitted = filePath.substring(0, (lastIndex));
  final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    outPath,
    quality: 65,
  );

  return result;
}
