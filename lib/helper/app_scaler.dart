import 'package:flutter/cupertino.dart';

extension DeviceSize on BuildContext {
  double width() => MediaQuery.of(this).size.width;
  double height() => MediaQuery.of(this).size.height;
  double insets() => MediaQuery.of(this).viewInsets.bottom;
}
