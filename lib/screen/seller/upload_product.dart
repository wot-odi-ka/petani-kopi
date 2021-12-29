import 'dart:io';
import 'dart:typed_data';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petani_kopi/bloc/permission_bloc/permission_bloc.dart';
import 'package:petani_kopi/bloc/permission_bloc/permission_event.dart';
import 'package:petani_kopi/bloc/permission_bloc/permission_state.dart';
import 'package:petani_kopi/bloc/product_bloc/product_bloc.dart';
import 'package:petani_kopi/bloc/product_bloc/product_event.dart';
import 'package:petani_kopi/bloc/product_bloc/product_state.dart';
import 'package:petani_kopi/bloc/profil_block/profil_block.dart';
import 'package:petani_kopi/bloc/profil_block/profil_event.dart';
import 'package:petani_kopi/bloc/profil_block/profil_state.dart';
import 'package:petani_kopi/common/common_carousel.dart';
import 'package:petani_kopi/common/common_detail_animation.dart';
import 'package:petani_kopi/common/common_loading.dart';
import 'package:petani_kopi/common/common_profile_tile.dart';
import 'package:petani_kopi/common/common_upload_choice.dart';
import 'package:petani_kopi/common/custom_gallery/gallery_utils.dart';
import 'package:petani_kopi/common/expandables.dart';
import 'package:petani_kopi/helper/app_scaler.dart';
import 'package:petani_kopi/helper/constants.dart';
import 'package:petani_kopi/helper/snack_bar.dart';
import 'package:petani_kopi/helper/utils.dart';
import 'package:petani_kopi/model/product.dart';
import 'package:petani_kopi/model/users.dart';
import 'package:petani_kopi/service/jump.dart';
import 'package:petani_kopi/theme/colors.dart';
import 'package:blurhash/blurhash.dart' as blur;

class UploadProduct extends StatelessWidget {
  final bool isRegister;
  const UploadProduct({Key? key, required this.isRegister}) : super(key: key);

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
        BlocProvider<ProfilBlock>(
          create: (context) => ProfilBlock()..add(ProfilInitEvent()),
        ),
      ],
      child: UploadProductBody(isRegister: isRegister),
    );
  }
}

class UploadProductBody extends StatefulWidget {
  final bool isRegister;
  const UploadProductBody({Key? key, required this.isRegister})
      : super(key: key);

  @override
  _UploadProductBodyState createState() => _UploadProductBodyState();
}

class _UploadProductBodyState extends State<UploadProductBody>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController animation;
  ScrollController scrollController = ScrollController();
  TextEditingController nameProductCo = TextEditingController();
  TextEditingController typeProductCo = TextEditingController();
  TextEditingController descProductCo = TextEditingController();
  TextEditingController hargaProductCo = TextEditingController();
  FocusNode nameProductNode = FocusNode();
  FocusNode typeProductNode = FocusNode();
  FocusNode descProductNode = FocusNode();
  FocusNode hargaProductNode = FocusNode();
  List<CarouselArg> arg = [];
  Product product = Product();
  Users user = Users();

  @override
  void initState() {
    _pageController = PageController(
      keepPage: false,
      viewportFraction: 0.94,
    );
    animation = AnimationController(
      duration: const Duration(microseconds: 1),
      vsync: this,
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    _pageController.dispose();
    animation.dispose();
    super.dispose();
  }

  bloc(ProductEvent event) {
    BlocProvider.of<ProductBloc>(context).add(event);
  }

  permissionBloc(PermissionEvent event) {
    BlocProvider.of<PermissionBloc>(context).add(event);
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
        BlocListener<ProfilBlock, ProfilState>(
          listener: (context, state) {
            if (state is InitUserProfileDone) {
              setState(() {
                user = state.user;
              });
            }
            if (state is UserProfileFailed) {
              context.fail(state.error);
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return blocListener(
      child: Scaffold(
        backgroundColor: backgroundColor,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: mainColor,
          ),
        ),
        body: blocBuilder(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SizedBox(
              height: context.height(),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    Container(
                      width: context.width(),
                      decoration: const BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(40),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => Jump.back(),
                                ),
                                const Text(
                                  'Upload Product',
                                  style: TextStyle(
                                    color: backgroundColor,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                // const SizedBox(width: 32),
                                condition()
                                    ? GestureDetector(
                                        onTap: () => onSubmit(),
                                        child: const Text(
                                          'Save',
                                          style: TextStyle(
                                            color: backgroundColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      )
                                    : const SizedBox(width: 32),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                  child: SizedBox(
                                    width: 80.0,
                                    height: 80.0,
                                    child: CommonDetailAnimation(
                                      detail: DetailUserImage(
                                        imageHash: user.userImageHash ??
                                            Const.emptyHash,
                                        imageUrl:
                                            user.userImage ?? Const.emptyImage,
                                      ),
                                      child: BlurHash(
                                        hash: user.userImageHash ??
                                            Const.emptyHash,
                                        image:
                                            user.userImage ?? Const.emptyImage,
                                        imageFit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.userMail ?? '',
                                      style: const TextStyle(
                                        color: backgroundColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      user.userName ?? '',
                                      style: const TextStyle(
                                        color: backgroundColor,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                ExpandableWidget(
                                  expand: arg.length < 3,
                                  direction: Axis.horizontal,
                                  child: AvatarGlow(
                                    glowColor: backgroundColor,
                                    endRadius: 30,
                                    duration:
                                        const Duration(milliseconds: 2000),
                                    repeat: true,
                                    showTwoGlows: true,
                                    repeatPauseDuration: const Duration(
                                      milliseconds: 100,
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: oldCoffee,
                                      child: IconButton(
                                        alignment: Alignment.center,
                                        onPressed: () => showUploadChoice(),
                                        icon: const Icon(
                                          IconlyLight.camera,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ExpandableWidget(
                              expand: arg.isNotEmpty,
                              child: Visibility(
                                visible: arg.isNotEmpty,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 24),
                                    SizedBox(
                                      height: 220,
                                      child: PageView.builder(
                                        itemCount: arg.length,
                                        controller: _pageController,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return CommonCarousel(
                                            controller: _pageController,
                                            animation: animation,
                                            model: arg[index],
                                            onDel: () => onDel(arg[index]),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 18,
                        top: 8,
                        right: 18,
                      ),
                      width: context.width(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          CommonProfileTileField(
                            node: nameProductNode,
                            controller: nameProductCo,
                            hint: 'Product Name',
                          ),
                          const SizedBox(height: 16),
                          CommonProfileTileField(
                            node: typeProductNode,
                            controller: typeProductCo,
                            hint: 'Coffee Type',
                            tileType: TileType.drop,
                            items: Const.cofeeType,
                          ),
                          const SizedBox(height: 16),
                          CommonProfileTileField(
                            node: descProductNode,
                            controller: descProductCo,
                            hint: 'Product Description',
                          ),
                          const SizedBox(height: 16),
                          CommonProfileTileField(
                            textInputType: TextInputType.number,
                            node: hargaProductNode,
                            controller: hargaProductCo,
                            hint: 'Product Price',
                            formatter: [
                              FilteringTextInputFormatter.digitsOnly,
                              CurrencyInputFormatter(),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onDel(CarouselArg data) {
    setState(() {
      arg.removeWhere((element) => element.index == data.index);
    });
  }

  showUploadChoice() {
    if (arg.length >= 3) {
      context.fail('Max Image Reached');
    } else {
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
  }

  galery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      File? compressed = await compressFile(File(photo.path));
      if (compressed != null) {
        Uint8List bytes = await compressed.readAsBytes();
        String hash = await blur.BlurHash.encode(bytes, 2, 2);
        setState(() {
          var data = CarouselArg();
          data.index = arg.length;
          data.image = compressed;
          data.hash = hash;
          arg.add(data);
        });
        _pageController.animateToPage(
          arg.length - 1,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 250),
        );
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
        setState(() {
          var data = CarouselArg();
          data.index = arg.length;
          data.image = compressed;
          data.hash = hash;
          arg.add(data);
        });
        _pageController.animateToPage(
          arg.length - 1,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 250),
        );
      }
    }
  }

  condition() => (nameProductCo.text.isNotEmpty &&
      descProductCo.text.isNotEmpty &&
      hargaProductCo.text.isNotEmpty &&
      arg.isNotEmpty);

  onSubmit() {
    Product data = Product();
    data.imagesHash = [];
    data.imagesUrl = [];
    data.initImage = [];
    data.namaProduct = nameProductCo.text;
    data.descProduct = descProductCo.text;
    data.hargaProduct = hargaProductCo.text;
    data.jenisKopi = typeProductCo.text;
    for (var item in arg) {
      data.initImage!.add(item.image!);
      data.imagesHash!.add(item.hash!);
    }
    if (widget.isRegister) {
      bloc(SubmitProduct(data));
    } else {
      bloc(RegisterProduct(data));
    }
  }
}
