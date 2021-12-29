import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petani_kopi/bloc/product_bloc/product_event.dart';
import 'package:petani_kopi/bloc/product_bloc/product_state.dart';
import 'package:petani_kopi/firebase_query.dart/login_query.dart';
import 'package:petani_kopi/firebase_query.dart/product_query.dart';
import 'package:petani_kopi/model/product.dart';
import 'package:petani_kopi/model/users.dart';
import 'package:petani_kopi/service/database.dart';
import 'package:path/path.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  Users users = Users();
  Product product = Product();
  List<String> imagesUrl = [];
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
        await massUpload(event.product.initImage ?? []);
        await updateData(event.product);
        emit(ProductOnLoaded());
      } else if (event is SubmitProduct) {
        emit(ProductOnLoading());
        await massUpload(event.product.initImage ?? []);
        await addProduct(event.product);
        emit(ProductOnLoaded());
      }
    } catch (e) {
      emit(ProductFiled(e.toString()));
    }
  }

  massUpload(List<File> files) async {
    if (files.isNotEmpty) {
      for (var element in files) {
        String fileName = basename(element.path);
        Reference ref = FirebaseStorage.instance.ref().child(fileName);
        UploadTask uploadTask = ref.putFile(element);
        TaskSnapshot task = await uploadTask.whenComplete(() => null);
        await task.ref.getDownloadURL().then((val) => imagesUrl.add(val));
      }
    }
  }

  updateData(Product eventData) async {
    eventData.userId = users.userId;
    eventData.userName = users.userName;
    eventData.userCity = users.userCity;
    eventData.userImage = users.userImage;
    eventData.userImageHash = users.userImageHash;
    eventData.imagesUrl!.addAll(imagesUrl);
    await ProductQuery.uploadProduct(eventData);
    await LogQuery.updateSellerStatus(users.userId!);
    users.userIsSeller = true;
    DB.saveUser(users);
  }

  addProduct(Product eventData) async {
    eventData.userId = users.userId;
    eventData.userName = users.userName;
    eventData.userCity = users.userCity;
    eventData.userImage = users.userImage;
    eventData.userImageHash = users.userImageHash;
    eventData.imagesUrl!.addAll(imagesUrl);
    await ProductQuery.uploadProduct(eventData);
  }
}
