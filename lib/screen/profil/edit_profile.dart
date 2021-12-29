import 'dart:io';

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
import 'package:petani_kopi/bloc/profil_block/profil_block.dart';
import 'package:petani_kopi/bloc/profil_block/profil_event.dart';
import 'package:petani_kopi/bloc/profil_block/profil_state.dart';
import 'package:petani_kopi/common/common_detail_animation.dart';
import 'package:petani_kopi/common/common_loading.dart';
import 'package:petani_kopi/common/common_profile_tile.dart';
import 'package:petani_kopi/common/common_upload_choice.dart';
import 'package:petani_kopi/common/custom_gallery/gallery_utils.dart';
import 'package:petani_kopi/helper/app_scaler.dart';
import 'package:petani_kopi/helper/constants.dart';
import 'package:petani_kopi/helper/snack_bar.dart';
import 'package:petani_kopi/model/users.dart';
import 'package:petani_kopi/service/jump.dart';
import 'package:petani_kopi/theme/colors.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfilBlock>(
          create: (context) => ProfilBlock()..add(ProfilInitEvent()),
        ),
        BlocProvider<PermissionBloc>(
          create: (context) => PermissionBloc(),
        ),
      ],
      child: const EditProfileBody(),
    );
  }
}

class EditProfileBody extends StatefulWidget {
  const EditProfileBody({Key? key}) : super(key: key);

  @override
  _EditProfileBodyState createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends State<EditProfileBody> {
  TextEditingController userNameCo = TextEditingController();
  TextEditingController phoneCo = TextEditingController();
  TextEditingController alamatCo = TextEditingController();
  TextEditingController cityCo = TextEditingController();
  TextEditingController noRekCo = TextEditingController();
  TextEditingController rekCo = TextEditingController();
  FocusNode userNameNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  FocusNode alamatNode = FocusNode();
  FocusNode cityNode = FocusNode();
  FocusNode noRekNode = FocusNode();
  FocusNode rekNode = FocusNode();
  late ScrollController scrollController;
  Users user = Users();
  File? image;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  bloc(ProfilEvent event) {
    BlocProvider.of<ProfilBlock>(context).add(event);
  }

  permissionBloc(PermissionEvent event) {
    BlocProvider.of<PermissionBloc>(context).add(event);
  }

  Widget blocBuilder({required Widget child}) {
    return BlocBuilder<ProfilBlock, ProfilState>(
      builder: (context, state) {
        if (state is ProfilOnLoading) {
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
        BlocListener<ProfilBlock, ProfilState>(
          listener: (context, state) {
            if (state is InitUserProfileDone) {
              insertData(state.user);
            }
            if (state is UserProfileFailed) {
              context.fail(state.error);
            }
            if (state is ProfileUpdated) {
              Jump.back();
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
                physics: const BouncingScrollPhysics(),
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
                            const SizedBox(height: 35),
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
                                  'Edit Profile',
                                  style: TextStyle(
                                    color: backgroundColor,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
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
                            const SizedBox(height: 36),
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
                                        imageHash: user.userImageHash ?? '',
                                        imageUrl: user.userImage ?? '',
                                      ),
                                      child: (image != null)
                                          ? Image.file(
                                              image!,
                                              fit: BoxFit.cover,
                                            )
                                          : BlurHash(
                                              hash: user.userImageHash ??
                                                  Const.emptyHash,
                                              image: user.userImage ??
                                                  Const.emptyImage,
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
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4,
                                        horizontal: 6,
                                      ),
                                      decoration: const BoxDecoration(
                                        color: backgroundColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            user.userIsSeller ?? false
                                                ? IconlyBold.star
                                                : IconlyLight.star,
                                            size: 12,
                                          ),
                                          const SizedBox(width: 3),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 2,
                                            ),
                                            child: Text(
                                              user.userIsSeller ?? false
                                                  ? 'User Is a Seller'
                                                  : 'User not a Seller yet',
                                              style: const TextStyle(
                                                color: mainColor,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                AvatarGlow(
                                  glowColor: backgroundColor,
                                  endRadius: 30,
                                  duration: const Duration(milliseconds: 2000),
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
                              ],
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 18, top: 8, right: 18),
                      width: context.width(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          CommonProfileTileField(
                            node: userNameNode,
                            controller: userNameCo,
                            hint: 'Username',
                            icon: IconlyLight.profile,
                          ),
                          const SizedBox(height: 16),
                          CommonProfileTileField(
                            node: phoneNode,
                            textInputType: TextInputType.number,
                            controller: phoneCo,
                            hint: 'Phone Number',
                            icon: IconlyLight.call,
                          ),
                          const SizedBox(height: 16),
                          CommonProfileTileField(
                            node: alamatNode,
                            controller: alamatCo,
                            hint: 'Address',
                            icon: IconlyLight.location,
                          ),
                          const SizedBox(height: 16),
                          CommonProfileTileField(
                            node: cityNode,
                            controller: cityCo,
                            hint: 'City',
                            tileType: TileType.drop,
                            items: Const.city,
                            icon: IconlyLight.location,
                          ),
                          const SizedBox(height: 16),
                          CommonProfileTileField(
                            node: rekNode,
                            controller: rekCo,
                            hint: 'Account',
                            tileType: TileType.drop,
                            items: Const.rekening,
                            icon: IconlyLight.wallet,
                          ),
                          const SizedBox(height: 16),
                          CommonProfileTileField(
                            node: noRekNode,
                            textInputType: TextInputType.number,
                            controller: noRekCo,
                            hint: 'Account Number',
                            icon: IconlyLight.wallet,
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

  onSubmit() {
    Users data = Users();
    data.userName = userNameCo.text;
    data.userMail = user.userMail;
    data.userPhone = phoneCo.text;
    data.userAlamat = alamatCo.text;
    data.userCity = cityCo.text;
    data.rekening = rekCo.text;
    data.noRekening = noRekCo.text;
    data.file = image;
    bloc(SubmitUpdateProfile(data));
  }

  insertData(Users data) {
    user = data;
    userNameCo.text = user.userName!;
    phoneCo.text = user.userPhone!;
    alamatCo.text = user.userAlamat!;
    cityCo.text = user.userCity!;
    rekCo.text = user.rekening!;
    noRekCo.text = user.noRekening!;
    setState(() {});
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

  galery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      File? compressed = await compressFile(File(photo.path));
      if (compressed != null) {
        setState(() {
          image = compressed;
        });
      }
    }
  }

  onCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      File? compressed = await compressFile(File(photo.path));
      if (compressed != null) {
        setState(() {
          image = compressed;
        });
      }
    }
  }

  condition() => (userNameCo.text != user.userName ||
      alamatCo.text != user.userAlamat ||
      phoneCo.text != user.userPhone ||
      image != null ||
      cityCo.text.isNotEmpty &&
          rekCo.text.isNotEmpty &&
          noRekCo.text.isNotEmpty);
}
