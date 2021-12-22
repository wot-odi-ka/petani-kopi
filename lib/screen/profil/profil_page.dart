// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petani_kopi/bloc/auth_bloc/auth_bloc.dart';
import 'package:petani_kopi/bloc/permission_bloc/permission_bloc.dart';
import 'package:petani_kopi/bloc/permission_bloc/permission_event.dart';
import 'package:petani_kopi/bloc/permission_bloc/permission_state.dart';
import 'package:petani_kopi/bloc/profil_block/profil_block.dart';
import 'package:petani_kopi/bloc/profil_block/profil_event.dart';
import 'package:petani_kopi/bloc/profil_block/profil_state.dart';
import 'package:petani_kopi/common/common_button.dart';
import 'package:petani_kopi/common/common_detail_animation.dart';
import 'package:petani_kopi/common/common_loading.dart';
import 'package:petani_kopi/common/common_profile_text.dart';
import 'package:petani_kopi/common/common_shimmer.dart';
import 'package:petani_kopi/common/common_upload_choice.dart';
import 'package:petani_kopi/common/custom_gallery/gallery_utils.dart';
import 'package:petani_kopi/helper/app_scaler.dart';
import 'package:petani_kopi/helper/constants.dart';
import 'package:petani_kopi/helper/page.dart';
import 'package:petani_kopi/helper/snack_bar.dart';
import 'package:petani_kopi/model/users.dart';
import 'package:petani_kopi/screen/profil/common_profile_tile.dart';
import 'package:petani_kopi/screen/profil/profile_bar.dart';
import 'package:petani_kopi/screen/profil/profile_page_button.dart';
import 'package:petani_kopi/service/jump.dart';
import 'package:petani_kopi/theme/colors.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<ProfilBlock>(
        create: (context) => ProfilBlock()..add(ProfilInitEvent()),
      ),
      BlocProvider<PermissionBloc>(
        create: (context) => PermissionBloc(),
      ),
    ], child: const EditPage());
  }
}

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late ScrollController scrollController;
  TextEditingController userNameCo = TextEditingController();
  TextEditingController alamatCo = TextEditingController();
  TextEditingController emailCo = TextEditingController();
  TextEditingController noHpCo = TextEditingController();
  FocusNode nameNode = FocusNode();
  FocusNode profileNode = FocusNode();
  FocusNode alamatNode = FocusNode();
  FocusNode noHpNode = FocusNode();
  String email = '';
  String userName = '';
  String profile = '';
  String noHp = '';
  String alamat = '';
  Users user = Users();
  bool nameEdit = false;
  bool profileEdit = false;
  bool noHpEdit = false;
  bool alamatEdit = false;

  double scrollPosition = 0;
  double opacity = 0;
  File? image;
  bool showPassword = false;
  bool isLoading = false;
  late Timer? timer;

  myToko() {
    setState(() {
      isLoading = true;
    });
    const oneSec = Duration(seconds: 1);

    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          isLoading = false;
          timer.cancel();
          Jump.replace(Pages.myShopPage);
        });
      },
    );
  }

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    super.initState();
  }

  scrollListener() {
    setState(() {
      scrollPosition = scrollController.position.pixels;
    });
  }

  scrollOpacity() {
    opacity = scrollPosition < context.height() * 0.40
        ? scrollPosition / (context.height() * 0.40)
        : 1;
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollOpacity);
    scrollController.dispose();
    nameNode.dispose();
    profileNode.dispose();
    userNameCo.dispose();
    alamatCo.dispose();
    super.dispose();
  }

  bloc(ProfilEvent event) {
    BlocProvider.of<ProfilBlock>(context).add(event);
  }

  permissionBloc(PermissionEvent event) {
    BlocProvider.of<PermissionBloc>(context).add(event);
  }

  @override
  Widget build(BuildContext context) {
    scrollOpacity();
    if (!nameEdit && !profileEdit) {
      scrollPosition = 0;
      scrollOpacity();
    }
    return blocListener(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(),
            child: ProfileBar(
              user: user,
              opacity: opacity,
              changeImage: () => showUploadChoice(),
            ),
          ),
        ),
        body: blocBuilder(
          child: Container(
            padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
            child: SizedBox(
              height: context.height(),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),

                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: context.width() * 0.50,
                              height: context.height() * 0.25,
                              child: CommonDetailAnimation(
                                detail: DetailUserImage(
                                  imageHash:
                                      user.userImageHash ?? Const.emptyHash,
                                  imageUrl: user.userImage ?? Const.emptyImage,
                                ),
                                child: (image != null)
                                    ? Image.file(
                                        image!,
                                        fit: BoxFit.cover,
                                      )
                                    : BlurHash(
                                        hash: user.userImageHash ??
                                            Const.emptyHash,
                                        image:
                                            user.userImage ?? Const.emptyImage,
                                        imageFit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            Positioned(
                              bottom: -8,
                              right: -5,
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
                                        Icons.mode_edit,
                                        color: Colors.white,
                                      )),
                                  radius: 20.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  const CommonProfileText(text: 'Email'),
                  CommonProfileTile(
                    enableEdit: false,
                    text: email,
                  ),
                  const Divider(
                    height: 1,
                    color: mainColor,
                    indent: 15,
                    endIndent: 15,
                  ),
                  const SizedBox(height: 30),
                  const CommonProfileText(text: 'Username'),
                  CommonProfileTile(
                    node: nameNode,
                    controller: userNameCo,
                    text: userName,
                    onEdit: nameEdit,
                    onTapEdit: () => onNameTap(),
                    onClosed: () => onNameTap(),
                  ),
                  const Divider(
                    height: 1,
                    color: mainColor,
                    indent: 15,
                    endIndent: 15,
                  ),
                  const SizedBox(height: 30),
                  const CommonProfileText(text: 'No.Handphone'),
                  CommonProfileTile(
                    node: noHpNode,
                    controller: noHpCo,
                    text: noHp,
                    onEdit: noHpEdit,
                    onTapEdit: () => onNohpTap(),
                    onClosed: () => onNohpTap(),
                  ),
                  const Divider(
                    height: 0,
                    color: mainColor,
                    indent: 10,
                    endIndent: 10,
                  ),
                  const SizedBox(height: 30),
                  const CommonProfileText(text: 'Alamat'),
                  CommonProfileTile(
                    node: alamatNode,
                    controller: alamatCo,
                    text: alamat,
                    onEdit: alamatEdit,
                    onTapEdit: () => onAlamatpTap(),
                    onClosed: () => onAlamatpTap(),
                  ),
                  const Divider(
                    height: 0,
                    color: mainColor,
                    indent: 10,
                    endIndent: 10,
                  ),
                  const SizedBox(height: 15),
                  (user.userIsSeller ?? false)
                      ? ButtonConfirm(
                          text: 'Toko Saya',
                          onTap: () {
                            Jump.to(Pages.myShopPage);
                          },
                        )
                      : ButtonConfirm(
                          text: 'Mulai Jual',
                          onTap: () {
                            Jump.to(Pages.sellerPage).then((_) {
                              bloc(ProfilInitEvent());
                            });
                          },
                        ),

                  const SizedBox(
                    height: 15,
                  ),

                  // const SizedBox(height: 20),
                  // // buildTextField('Full Name', userName, false, userNameCo),
                  // // buildTextField('E-mail', email, false, emailCo),
                  // // buildTextField('No.HP', noHp, true, noHpCo),
                  // // buildTextField('Alamat', alamat, false, alamatCo),
                  // const Text(
                  //   'Mulai Jual',
                  //   textAlign: TextAlign.center,
                  // ),
                  // Container(
                  //   alignment: Alignment.center,
                  //   child: AvatarGlow(
                  //     glowColor: Colors.brown,
                  //     endRadius: 30,
                  //     duration: const Duration(milliseconds: 2000),
                  //     repeat: true,
                  //     showTwoGlows: true,
                  //     repeatPauseDuration: const Duration(milliseconds: 100),
                  //     child: CircleAvatar(
                  //       backgroundColor: Colors.brown[900],
                  //       child: IconButton(
                  //           alignment: Alignment.center,
                  //           onPressed: () {
                  //             print('tesssstt');
                  //             Jump.replace(Pages.sellerPage);
                  //           },
                  //           icon: const Icon(
                  //             Icons.store_outlined,
                  //             color: Colors.white,
                  //             semanticLabel: ('Mulai Jual'),
                  //           )),
                  //       radius: 23.0,
                  //     ),
                  //   ),
                  // ),
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
            if (state is ProfileUpdated) {
              image = null;
              insertData(state.newUser);
            }
            if (state is UserProfileFailed) {
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

  insertData(Users data) {
    user = data;
    email = user.userMail!;
    userName = user.userName!;
    noHp = user.userPhone!;
    alamat = user.userAlamat!;
    userNameCo.text = userName;
    noHpCo.text = noHp;
    emailCo.text = email;
    alamatCo.text = alamat;

    setState(() {});
  }

  onSubmit() {
    Users data = Users();
    data.userName = userName;
    data.userMail = email;
    data.userPhone = noHp;
    data.userAlamat = alamat;
    data.file = image;
    bloc(SubmitUpdateProfile(data));
  }

  onUndo() {
    setState(() {
      userName = user.userName!;
      profile = user.userProfile!;
      alamat = user.userAlamat!;
      noHp = user.userPhone!;
      userNameCo.text = userName;
      alamatCo.text = alamat;
      noHpCo.text = noHp;
      image = null;
    });
  }

  onNameTap() {
    nameEdit = !nameEdit;
    userName = userNameCo.text;
    if (alamatEdit && noHpEdit) {
      alamatEdit = false;
      noHpEdit = false;
    }
    if (nameEdit) {
      nameNode.requestFocus();
    }
    setState(() {});
  }

  onNohpTap() {
    noHpEdit = !noHpEdit;
    noHp = noHpCo.text;
    if (alamatEdit && nameEdit) {
      alamatEdit = false;
      nameEdit = false;
    }
    if (noHpEdit) {
      noHpNode.requestFocus();
    }
    setState(() {});
  }

  onAlamatpTap() {
    alamatEdit = !alamatEdit;
    alamat = alamatCo.text;
    if (noHpEdit && nameEdit) {
      noHpEdit = false;
      nameEdit = false;
    }
    if (alamatEdit) {
      alamatNode.requestFocus();
    }
    setState(() {});
  }

  onProfileTap() {
    profileEdit = !profileEdit;
    profile = alamatCo.text;
    if (nameEdit) {
      nameEdit = false;
    }
    if (profileEdit) {
      profileNode.requestFocus();
    }
    setState(() {});
  }

  condition() {
    return (userName != user.userName ||
        alamat != user.userAlamat ||
        noHp != user.userPhone ||
        image != null);
  }

  // onStorage() async {
  //   File? result = await Navigator.push(
  //     context,
  //     CupertinoPageRoute(
  //       builder: (context) => const CustomGallery(),
  //     ),
  //   );

  //   if (result != null) {
  //     setState(() {
  //       image = result;
  //     });
  //   }
  // }

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
}

Widget buildTextField(String labelText, String placeholder,
    bool isPasswordTextField, TextEditingController? controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 35.0),
    child: TextField(
      decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.mobile_friendly,
                    color: Colors.grey,
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.only(bottom: 3),
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 20, color: Colors.black),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
    ),
  );
}
