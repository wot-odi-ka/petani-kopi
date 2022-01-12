import 'package:flutter/cupertino.dart';

extension NextFocus on BuildContext {
  nextFocus(FocusNode node) {
    FocusScope.of(this).unfocus();
    node.requestFocus();
  }
}

extension CommonString on String {
  String removeDot() {
    return (this).replaceAll('.', '');
  }

  int dotParse() {
    return int.parse((this).removeDot());
  }
}
