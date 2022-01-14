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

  List<KeyVal> confirmed = [
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

  List<KeyVal> packaging = [
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

  List<KeyVal> send = [
    KeyVal(
      label: 'Order Send',
      value: Const.send,
    ),
    KeyVal(
      label: 'Order Done',
      value: Const.done,
    ),
  ];

  List<KeyVal> done = [
    KeyVal(
      label: 'Order Done',
      value: Const.done,
    ),
  ];

  List<KeyVal> getList(String status) {
    List<KeyVal> result = [];
    if (status == Const.notConfirmed) {
      result.addAll(list);
    } else if (status == Const.confirmed) {
      result.addAll(confirmed);
    } else if (status == Const.packaging) {
      result.addAll(packaging);
    } else if (status == Const.send) {
      result.addAll(send);
    } else if (status == Const.done) {
      result.addAll(done);
    } else {
      throw 'waloyo';
    }

    return result;
  }
}
