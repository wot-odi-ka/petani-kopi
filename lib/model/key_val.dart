import 'package:petani_kopi/helper/constants.dart';

class KeyVal {
  String? label;
  String? value;
  int index;
  KeyVal({
    this.label,
    this.value,
    this.index = 0,
  });
}

class KeyOrderStatus {
  List<KeyVal> list = [
    KeyVal(
      label: 'Not Confirmed',
      value: Const.notConfirmed,
      index: 0,
    ),
    KeyVal(
      label: 'Confirmed',
      value: Const.confirmed,
      index: 1,
    ),
    KeyVal(
      label: 'Packaging',
      value: Const.packaging,
      index: 2,
    ),
    KeyVal(
      label: 'Order Send',
      value: Const.send,
      index: 3,
    ),
    KeyVal(
      label: 'Order Done',
      value: Const.done,
      index: 4,
    ),
  ];

  List<KeyVal> notConfirmed = [
    KeyVal(
      label: 'Not Confirmed',
      value: Const.notConfirmed,
      index: 0,
    ),
    KeyVal(
      label: 'Confirmed',
      value: Const.confirmed,
      index: 1,
    ),
    KeyVal(
      label: 'Packaging',
      value: Const.packaging,
      index: 2,
    ),
    KeyVal(
      label: 'Order Send',
      value: Const.send,
      index: 3,
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
  ];

  List<KeyVal> send = [
    KeyVal(
      label: 'Order Send',
      value: Const.send,
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
      result.addAll(notConfirmed);
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
