import 'dart:async';
import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:iconly/iconly.dart';
import 'package:petani_kopi/bloc/permission_bloc/permission_bloc.dart';
import 'package:petani_kopi/bloc/permission_bloc/permission_event.dart';
import 'package:petani_kopi/bloc/permission_bloc/permission_state.dart';
import 'package:petani_kopi/bloc/product_bloc/product_bloc.dart';
import 'package:petani_kopi/bloc/product_bloc/product_event.dart';
import 'package:petani_kopi/bloc/product_bloc/product_state.dart';
import 'package:petani_kopi/common/common_detail_animation.dart';
import 'package:petani_kopi/common/common_loading.dart';
import 'package:petani_kopi/common/common_textfield.dart';
import 'package:petani_kopi/common/common_upload_choice.dart';
import 'package:petani_kopi/common/custom_gallery/gallery_utils.dart';
import 'package:petani_kopi/helper/app_scaler.dart';
import 'package:petani_kopi/helper/constants.dart';
import 'package:petani_kopi/helper/page.dart';
import 'package:petani_kopi/helper/snack_bar.dart';
import 'package:petani_kopi/model/product.dart';
import 'package:petani_kopi/service/jump.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petani_kopi/theme/colors.dart';

class SellerPage extends StatelessWidget {
  const SellerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(),
        ),
        BlocProvider<PermissionBloc>(
          create: (context) => PermissionBloc(),
        ),
      ],
      child: const SellerBoddy(),
    );
  }
}

class SellerBoddy extends StatefulWidget {
  const SellerBoddy({Key? key}) : super(key: key);

  @override
  _SellerBoddyState createState() => _SellerBoddyState();
}

class _SellerBoddyState extends State<SellerBoddy> {
  FocusNode nameNode = FocusNode();
  FocusNode profileNode = FocusNode();
  TextEditingController nameProductCo = TextEditingController();
  TextEditingController jenisProductCo = TextEditingController();
  TextEditingController descProductCo = TextEditingController();
  TextEditingController hargaProductCo = TextEditingController();
  Product product = Product();
  bool nameEdit = false;
  bool profileEdit = false;
  double scrollPosition = 0;
  double opacity = 0;
  File? image;
  bool showPassword = false;
  bool isLoading = false;
  late Timer? timer;

  bloc(ProductEvent event) {
    BlocProvider.of<ProductBloc>(context).add(event);
  }

  permissionBloc(PermissionEvent event) {
    BlocProvider.of<PermissionBloc>(context).add(event);
  }

  @override
  Widget build(BuildContext context) {
    return blocListener(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color(0xFF0d1015),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Jump.replace(Pages.profilPage);
            },
          ),
          title: const Text(
            'Registrasi Penjualan',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.white,
        body: blocBuilder(
          child: Container(
            padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
            child: ListView(
              children: [
                const Text(
                  'Upload Product',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Stack(
                    children: [
                      SizedBox(
                        width: context.width() * 0.50,
                        height: context.height() * 0.25,
                        child: CommonDetailAnimation(
                          detail: DetailUserImage(
                            imageHash: product.imageHas ?? Const.emptyHash,
                            imageUrl:
                                product.imageUrlProduct ?? Const.emptyImage,
                          ),
                          child: (image != null)
                              ? Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                )
                              : BlurHash(
                                  hash: product.imageHas ?? Const.emptyHash,
                                  image: product.imageUrlProduct ??
                                      Const.emptyImage,
                                  imageFit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        right: 0,
                        child: AvatarGlow(
                          glowColor: Colors.brown,
                          endRadius: 30,
                          duration: const Duration(milliseconds: 2000),
                          repeat: true,
                          showTwoGlows: true,
                          repeatPauseDuration:
                              const Duration(milliseconds: 100),
                          child: CircleAvatar(
                            backgroundColor: Colors.brown,
                            child: IconButton(
                                alignment: Alignment.center,
                                onPressed: () => showUploadChoice(),
                                icon: const Icon(
                                  Icons.add_a_photo_rounded,
                                  color: Colors.white,
                                )),
                            radius: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CommonTextfield(
                  controller: nameProductCo,
                  hint: 'Nama Product',
                  prefixIcon: IconlyLight.edit,
                ),
                const SizedBox(
                  height: 15,
                ),
                CommonTextfield(
                  controller: jenisProductCo,
                  hint: 'jenis Product',
                  prefixIcon: IconlyLight.edit,
                ),
                const SizedBox(
                  height: 15,
                ),
                CommonTextfield(
                  controller: descProductCo,
                  hint: 'Descripsi Product',
                  prefixIcon: IconlyLight.edit,
                ),
                const SizedBox(
                  height: 15,
                ),
                CommonTextfield(
                  controller: hargaProductCo,
                  hint: 'Harga Product',
                  prefixIcon: IconlyLight.edit,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ignore: deprecated_member_use
                    RaisedButton(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        Jump.replace(Pages.homePage);
                      },
                      color: const Color(0xFF1C1428),
                      child: const Text('CANCEL',
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white)),
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      onPressed: () => onSubmit(),
                      color: const Color(0xFF1C1428),
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        'SAVE',
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showUploadChoice() {
    return showModalBottomSheet(
      context: context,
      backgroundColor: backgroundColor,
      builder: (context) => SelectMediaBody(
        camera: () {
          Navigator.of(context).pop();
          permissionBloc(GetCameraPermission());
        },
        gallery: () {
          Navigator.of(context).pop();
          permissionBloc(GetStoragePermission());
        },
      ),
    );
  }

  Widget blocBuilder({required Widget child}) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductOnLoading) {
          return const CommonLoading();
        } else {
          return child;
        }
      },
    );
  }

  Widget blocListener({required Widget child}) {
    return MultiBlocListener(
      child: child,
      listeners: [
        BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductOnLoaded) {
              Jump.back();
            }

            if (state is ProductFiled) {
              context.fail(state.error);
            }
          },
        ),
        BlocListener<PermissionBloc, PermissionState>(
          listener: (context, state) {
            if (state is StoragePermissionGranted) {
              galery();
            }
            if (state is CameraPermissionGranted) {
              onCamera();
            }
            if (state is PermissionFailed) {
              context.fail(state.error);
            }
          },
        ),
      ],
    );
  }

  galery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      File? compressed = await compressFile(File(photo.path));
      if (compressed != null) {
        setState(() {
          image = File(photo.path);
        });
      }
    }
  }

  //akses camera
  onCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      File? compressed = await compressFile(File(photo.path));
      if (compressed != null) {
        setState(() {
          image = File(photo.path);
        });
      }
    }
  }

  onSubmit() {
    Product data = Product();
    data.namaProduct = nameProductCo.text;
    data.jenisProduct = jenisProductCo.text;
    data.descProduct = descProductCo.text;
    data.hargaProduct = hargaProductCo.text;
    data.file = image;
    bloc(RegisterProduct(data));
  }
}
