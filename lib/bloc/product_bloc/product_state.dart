class ProductState {}

class InitialProductState extends ProductState {}

class ProductOnLoading extends ProductState {}

class ProductOnLoaded extends ProductState {}

class ProductUpdate extends ProductState {}

class ProductFiled extends ProductState {
  final String error;
  ProductFiled(this.error);
}
