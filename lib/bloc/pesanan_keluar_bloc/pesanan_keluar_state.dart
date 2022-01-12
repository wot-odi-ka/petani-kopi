class PesananKeluarState {}

class PesnanKeluarInitialstate extends PesananKeluarState {}

class PesananKeluarLoading extends PesananKeluarState {}

class PesananKeluarLoaded extends PesananKeluarState {}

class PesananKeluarDone extends PesananKeluarState {}

class PesananKeluarFiled extends PesananKeluarState {
  final String error;

  PesananKeluarFiled(this.error);
}
