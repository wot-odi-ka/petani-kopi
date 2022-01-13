class PesananMasukState {}

class InitPesananMasuk extends PesananMasukState {}

class InitPesananMasukLoading extends PesananMasukState {}

class InitPesananMasukOnloaded extends PesananMasukState {}

class PesananMasukFiled extends PesananMasukState {
  final String error;

  PesananMasukFiled(this.error);
}
