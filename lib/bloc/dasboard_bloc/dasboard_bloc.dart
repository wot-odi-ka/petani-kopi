import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petani_kopi/bloc/dasboard_bloc/dasboard_event.dart';
import 'package:petani_kopi/bloc/dasboard_bloc/dasboard_state.dart';
import 'package:petani_kopi/firebase_query.dart/login_query.dart';
import 'package:petani_kopi/firebase_query.dart/product_query.dart';
import 'package:petani_kopi/model/product.dart';
import 'package:petani_kopi/model/shoplist.dart';
import 'package:petani_kopi/model/users.dart';
import 'package:petani_kopi/service/database.dart';

class DasboardBloc extends Bloc<DasboardEvent, DasboardState> {
  Users user = Users();
  Users shopOwner = Users();
  String? url;
  String? hash;
  Product product = Product();
  Stream<QuerySnapshot>? productStream;
  DasboardBloc() : super(DasboardInitialState()) {
    on<DasboardEvent>((event, emit) => start(event, emit));
  }

  start(DasboardEvent event, Emitter<DasboardState> emit) async {
    try {
      user = await DB.getUser();
      if (event is DasboardInitialEvent) {
        emit(DasboardOnlodingState());
        await initMyShop(event.searchVal, event.coffeeType);
        emit(DasboardOnloadedState(productStream!));
      } else if (event is DasboardViewEvent) {
        emit(DasboardOnlodingState());
        await getProduct(event.product);
        emit(GetProductSucsess(product));
      } else if (event is AddToCartEvent) {
        emit(AddCartSubmittin());
        await getOwnerData(event.product);
        await uploadCart(event.product);
        emit(AddCartSubmitted());
      }
    } catch (e) {
      emit(DasboardFiled(e.toString()));
    }
  }

  Future<void> initMyShop(String searchVal, String jenisKopi) async {
    Map<String, dynamic> map = {};
    map['userId'] = user.userId;
    map['searchVal'] = searchVal;
    map['jenisKopi'] = jenisKopi;
    productStream = await ProductQuery.getDashboardProduct(map);
  }

  Future<void> getProduct(Product init) async {
    product = await ProductQuery.getProductById(init.productId!);
  }

  Future<void> getOwnerData(Product product) async {
    shopOwner = await LogQuery.getUsersById(product.userId!);
    ShopList data = ShopList.map(shopOwner.toMap());
    data.totalPrice = product.totalPrice;
    await ProductQuery.addShopList(data, user);
  }

  Future<void> uploadCart(Product product) async {
    await ProductQuery.uploadCart(product, user);
  }
}
