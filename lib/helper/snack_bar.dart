import 'package:flutter/material.dart';

extension ShowBar on BuildContext {
  fail(String message) => ScaffoldMessenger.of(this)
    ..hideCurrentSnackBar()
    ..showSnackBar(failBar(message));

  done(String message) => ScaffoldMessenger.of(this)
    ..hideCurrentSnackBar()
    ..showSnackBar(doneBar(message));
}

failBar(String message) {
  return SnackBar(
    backgroundColor: Colors.redAccent,
    elevation: 3,
    content: Text(message),
  );
}

doneBar(String message) {
  return SnackBar(
    backgroundColor: Colors.greenAccent,
    elevation: 3,
    content: Text(message),
  );
}
