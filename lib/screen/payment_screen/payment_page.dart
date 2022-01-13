import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petani_kopi/bloc/cart_bloc/cart_bloc.dart';
import 'package:petani_kopi/bloc/cart_bloc/cart_event.dart';
import 'package:petani_kopi/bloc/cart_bloc/cart_state.dart';
import 'package:petani_kopi/bloc/permission_bloc/permission_bloc.dart';
import 'package:petani_kopi/bloc/permission_bloc/permission_event.dart';
import 'package:petani_kopi/bloc/permission_bloc/permission_state.dart';
import 'package:petani_kopi/common/common_empty_shop.dart';
import 'package:petani_kopi/common/common_expanded.dart';
import 'package:petani_kopi/common/common_shimmer.dart';
import 'package:petani_kopi/common/common_upload_choice.dart';
import 'package:petani_kopi/common/custom_gallery/gallery_utils.dart';
import 'package:petani_kopi/helper/app_scaler.dart';
import 'package:petani_kopi/helper/page.dart';
import 'package:petani_kopi/helper/snack_bar.dart';
import 'package:petani_kopi/model/cart_model.dart';
import 'package:blurhash/blurhash.dart' as blur;
import 'package:petani_kopi/screen/payment_screen/payment_item.dart';
import 'package:petani_kopi/service/jump.dart';
import 'package:petani_kopi/theme/colors.dart';

class PaymentPage extends StatelessWidget {
  final List<CartModel> checkedCartList;
  const PaymentPage({
    Key? key,
    required this.checkedCartList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
        BlocProvider<PermissionBloc>(
          create: (context) => PermissionBloc(),
        ),
      ],
      child: PaymentBody(checkedCartList: checkedCartList),
    );
  }
}

class PaymentBody extends StatefulWidget {
  final List<CartModel> checkedCartList;
  const PaymentBody({
    Key? key,
    required this.checkedCartList,
  }) : super(key: key);

  @override
  _PaymentBodyState createState() => _PaymentBodyState();
}

class _PaymentBodyState extends State<PaymentBody> {
  ScrollController scrollController = ScrollController();
  int selectedItem = 0;

  @override
  void initState() {
    placeIndex();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  bloc(CartEvent event) {
    BlocProvider.of<CartBloc>(context).add(event);
  }

  permissionBloc(PermissionEvent event) {
    BlocProvider.of<PermissionBloc>(context).add(event);
  }

  Widget blocListener({required Widget child}) => MultiBlocListener(
        child: child,
        listeners: [
          BlocListener<CartBloc, CartState>(
            listener: (context, state) {
              if (state is PaymentSubmitted) {
                widget.checkedCartList.removeWhere(
                  (element) => element.index! == state.index,
                );
                placeIndex();
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

  Widget listBuilder({required Widget child, required int index}) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) => CommonShimmer(
        isLoading: state is PaymentSubmitting && index == state.index,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return blocListener(
      child: Scaffold(
        backgroundColor: dashboardColor,
        body: SizedBox(
          height: context.height(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 35),
                    Text(
                      'Payment',
                      style: TextStyle(
                        color: backgroundColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: widget.checkedCartList.isNotEmpty,
                child: Flexible(
                  child: ExpandableWidget(
                    expand: widget.checkedCartList.isNotEmpty,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: widget.checkedCartList.length,
                      shrinkWrap: true,
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return listBuilder(
                          index: index,
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 48),
                            child: PaymentListBody(
                              model: widget.checkedCartList[index],
                              onTapImage: () => showUploadChoice(index),
                              onTapDone: () => bloc(
                                PaymentSubmitEvent(
                                    widget.checkedCartList[index]),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.checkedCartList.isEmpty,
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ExpandableWidget(
                            expand: widget.checkedCartList.isEmpty,
                            child: EmptyProducts(
                              onTap: () => Jump.to(Pages.homePage),
                              icon: IconlyLight.arrow_left_2,
                              text: 'Back to Home',
                              bodyColor: projectWhite,
                              textColor: dashboardColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showUploadChoice(int index) {
    selectedItem = index;
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

  galery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      File? compressed = await compressFile(File(photo.path));
      if (compressed != null) {
        Uint8List bytes = await compressed.readAsBytes();
        String hash = await blur.BlurHash.encode(bytes, 2, 2);
        widget.checkedCartList[selectedItem].receiptFile = compressed;
        widget.checkedCartList[selectedItem].receiptHash = hash;
        setState(() {});
      }
    }
  }

  onCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      File? compressed = await compressFile(File(photo.path));
      if (compressed != null) {
        Uint8List bytes = await compressed.readAsBytes();
        String hash = await blur.BlurHash.encode(bytes, 2, 2);
        widget.checkedCartList[selectedItem].receiptFile = compressed;
        widget.checkedCartList[selectedItem].receiptHash = hash;
        setState(() {});
      }
    }
  }

  void placeIndex() {
    for (var i = 0; i < widget.checkedCartList.length; i++) {
      widget.checkedCartList[i].index = i;
    }
    setState(() {});
  }
}
