class TypeBar {
  String? type;
  String? value;
  int? index;

  TypeBar({this.index, this.type, this.value});
}

class TypeBars {
  static List<TypeBar> bar = [
    TypeBar(
      value: '',
      type: 'All',
      index: 0,
    ),
    TypeBar(
      value: 'Americano',
      type: 'Americano',
      index: 1,
    ),
    TypeBar(
      value: 'Latte',
      type: 'Latte',
      index: 2,
    ),
    TypeBar(
      value: 'Cappuccino',
      type: 'Cappuccino',
      index: 3,
    ),
    TypeBar(
      value: 'Flat White',
      type: 'Flat White',
      index: 4,
    ),
    TypeBar(
      value: 'Es Kopi Susu',
      type: 'Es Kopi Susu',
      index: 5,
    ),
    TypeBar(
      value: 'Es Kopi Susu',
      type: 'Es Kopi Susu',
      index: 6,
    ),
    TypeBar(
      value: 'Cafe Au Lait',
      type: 'Cafe Au Lait',
      index: 7,
    ),
    TypeBar(
      value: 'Black Coffee',
      type: 'Black Coffee',
      index: 8,
    ),
    TypeBar(
      value: 'Espresso',
      type: 'Espresso',
      index: 9,
    ),
    TypeBar(
      value: 'Macchiato',
      type: 'Macchiato',
      index: 10,
    ),
  ];
}
