import 'package:petani_kopi/model/orderitemlist.dart';

class PesananMasukEvent {}

class InitPesananMasuk extends PesananMasukEvent {}

class GetCartPesanan extends PesananMasukEvent {
  final OrderList model;

  GetCartPesanan(this.model);
}
