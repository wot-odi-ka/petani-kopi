import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petani_kopi/bloc/my_shop_bloc/my_shop_event.dart';
import 'package:petani_kopi/bloc/my_shop_bloc/my_shop_state.dart';
import 'package:petani_kopi/firebase_query.dart/product_query.dart';
import 'package:petani_kopi/model/product.dart';
import 'package:petani_kopi/model/users.dart';
import 'package:petani_kopi/service/database.dart';

class MyShopBloc extends Bloc<MyShopEvent, MyShopState> {
  Stream<QuerySnapshot>? productStream;
  Users user = Users();
  MyShopBloc() : super(MyShopInitial()) {
    on<MyShopEvent>((event, emit) => start(event, emit));
  }

  start(MyShopEvent event, Emitter<MyShopState> emit) async {
    try {
      user = await DB.getUser();
      if (event is InitShopProducts) {
        emit(InitMyShopOnLoading());
        await initMyShop(event.searchVal, event.coffeeType);
        emit(InitMyShopLoaded(productStream!));
      } else if (event is DeleteProductById) {
        emit(ProductOnDeleting(event.index));
        await Future.delayed(const Duration(milliseconds: 500));
        await deleteProduct(event.product);
        emit(ProductDeleted());
      }
    } catch (e) {
      emit(MyShopFailed(e.toString()));
    }
  }

  Future<void> initMyShop(String searchVal, String jenisKopi) async {
    Map<String, dynamic> map = {};
    map['userId'] = user.userId;
    map['searchVal'] = searchVal;
    map['jenisKopi'] = jenisKopi;
    productStream = await ProductQuery.getProfileProduct(map);
  }

  Future<void> deleteProduct(Product data) async {
    data.userId = user.userId;
    await ProductQuery.deleteProduct(data);
  }
}
