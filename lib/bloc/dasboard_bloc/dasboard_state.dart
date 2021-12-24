class DasboardState {}

class DasboardInitialState extends DasboardState {}

class DasboardOnlodingState extends DasboardState {}

class DasboardOnloadedState extends DasboardState {}

class DasboardSucsess extends DasboardState {}

class DasboardFiled extends DasboardState {
  final String error;

  DasboardFiled(this.error);
}
