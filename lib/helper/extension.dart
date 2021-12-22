import 'package:flutter/cupertino.dart';

extension NextFocus on BuildContext {
  nextFocus(FocusNode node) {
    FocusScope.of(this).unfocus();
    node.requestFocus();
  }
}
