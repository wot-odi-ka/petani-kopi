import 'package:petani_kopi/helper/constants.dart';

class KeyVal {
  String? label;
  String? value;
  KeyVal({
    this.label,
    this.value,
  });
}

class KeyOrderStatus {
  List<KeyVal> list = [
    KeyVal(
      label: 'Not Confirmed',
      value: Const.notConfirmed,
    ),
    KeyVal(
      label: 'Confirmed',
      value: Const.confirmed,
    ),
    KeyVal(
      label: 'Packaging',
      value: Const.packaging,
    ),
    KeyVal(
      label: 'Order Send',
      value: Const.send,
    ),
    KeyVal(
      label: 'Order Done',
      value: Const.done,
    ),
  ];
}
