import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petani_kopi/bloc/product_bloc/product_event.dart';
import 'package:petani_kopi/bloc/product_bloc/product_state.dart';
import 'package:petani_kopi/firebase_query.dart/login_query.dart';
import 'package:petani_kopi/firebase_query.dart/product_query.dart';
import 'package:petani_kopi/helper/constants.dart';
import 'package:petani_kopi/model/product.dart';
import 'package:petani_kopi/model/users.dart';
import 'package:petani_kopi/service/database.dart';
import 'package:path/path.dart';
import 'package:blurhash/blurhash.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  Users users = Users();
  Product product = Product();
  String? url;
  String? hash;
  ProductBloc() : super(InitialProductState()) {
    on<ProductEvent>((event, emit) => start(event, emit));
  }

  start(ProductEvent event, Emitter<ProductState> emit) async {
    try {
      users = await DB.getUser();
      if (event is RegisterProduct) {
        emit(ProductOnLoading());
        await uploading(event.product.file);
        await updateData(event.product);
        emit(ProductOnLoaded());
      }
    } catch (e) {
      emit(ProductFiled(e.toString()));
    }
  }

  uploading(File? file) async {
    if (file != null) {
      String fileName = basename(file.path);
      Reference ref = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      await taskSnapshot.ref.getDownloadURL().then((value) => url = value);
      Uint8List bytes = await file.readAsBytes();
      await BlurHash.encode(bytes, 2, 2).then((value) => hash = value);
    }
  }

  updateData(Product eventData) async {
    eventData.userId = users.userId;
    eventData.imageUrlProduct = url ?? Const.emptyImage;
    eventData.imageHas = hash ?? Const.emptyHash;
    await ProductQuery.updateProduct(eventData);
    await LogQuery.updateSellerStatus(users.userId!);
    users.userIsSeller = true;
    DB.saveUser(users);
  }
}
