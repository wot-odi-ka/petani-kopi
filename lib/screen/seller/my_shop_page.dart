import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconly/iconly.dart';
import 'package:petani_kopi/bloc/my_shop_bloc/my_shop_bloc.dart';
import 'package:petani_kopi/bloc/my_shop_bloc/my_shop_event.dart';
import 'package:petani_kopi/bloc/my_shop_bloc/my_shop_state.dart';
import 'package:petani_kopi/bloc/profil_block/profil_block.dart';
import 'package:petani_kopi/bloc/profil_block/profil_event.dart';
import 'package:petani_kopi/bloc/profil_block/profil_state.dart';
import 'package:petani_kopi/common/common_alert_dialog.dart';
import 'package:petani_kopi/common/common_animated_switcher.dart';
import 'package:petani_kopi/common/common_detail_animation.dart';
import 'package:petani_kopi/common/common_empty_shop.dart';
import 'package:petani_kopi/common/common_loading.dart';
import 'package:petani_kopi/common/common_shimmer.dart';
import 'package:petani_kopi/common/common_tab_button.dart';
import 'package:petani_kopi/helper/app_scaler.dart';
import 'package:petani_kopi/helper/constants.dart';
import 'package:petani_kopi/helper/page.dart';
import 'package:petani_kopi/model/product.dart';
import 'package:petani_kopi/model/typebar_model.dart';
import 'package:petani_kopi/model/users.dart';
import 'package:petani_kopi/screen/seller/shop_items.dart';
import 'package:petani_kopi/service/jump.dart';
import 'package:petani_kopi/theme/colors.dart';

class MyShopScreen extends StatelessWidget {
  const MyShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfilBlock>(
          create: (context) => ProfilBlock()..add(ProfilInitEvent()),
        ),
        BlocProvider<MyShopBloc>(
          create: (context) => MyShopBloc(),
        ),
      ],
      child: const MyShopBody(),
    );
  }
}

class MyShopBody extends StatefulWidget {
  const MyShopBody({Key? key}) : super(key: key);

  @override
  _MyShopBodyState createState() => _MyShopBodyState();
}

class _MyShopBodyState extends State<MyShopBody> {
  Timer? searchOnStoppedTyping;
  TextEditingController searchCo = TextEditingController();
  FocusNode searchNode = FocusNode();
  late ScrollController scrollController;
  Stream<QuerySnapshot>? productStream;
  int selectedPage = 0;
  String selectedType = '';
  String searchVal = '';
  Users user = Users();

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

  profileBloc(ProfilEvent event) {
    BlocProvider.of<ProfilBlock>(context).add(event);
  }

  bloc(MyShopEvent event) {
    BlocProvider.of<MyShopBloc>(context).add(event);
  }

  Widget blocListener({required Widget child}) => MultiBlocListener(
        child: child,
        listeners: [
          BlocListener<ProfilBlock, ProfilState>(
            listener: (context, state) {
              if (state is InitUserProfileDone) {
                user = state.user;
                setState(() {});
                bloc(InitShopProducts('', ''));
              }
            },
          ),
          BlocListener<MyShopBloc, MyShopState>(
            listener: (context, state) {
              if (state is InitMyShopLoaded) {
                setState(() {
                  productStream = state.products;
                });
              }
            },
          ),
        ],
      );

  Widget bodyBuilder({required Widget child}) {
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

  Widget itemsBuilder({required Widget child}) {
    return BlocBuilder<MyShopBloc, MyShopState>(
      builder: (context, state) {
        if (state is InitMyShopOnLoading) {
          return const CommonLoading();
        } else {
          return child;
        }
      },
    );
  }

  Widget deleteBuilder({
    required Widget child,
    required int deletedIndex,
  }) {
    return BlocBuilder<MyShopBloc, MyShopState>(
      builder: (context, state) => CommonShimmer(
        isLoading: state is ProductOnDeleting && state.index == deletedIndex,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return blocListener(
      child: Scaffold(
        backgroundColor: dashboardColor,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: mainColor,
          ),
        ),
        body: bodyBuilder(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SizedBox(
              height: context.height(),
              child: Column(
                children: [
                  Container(
                    width: context.width(),
                    decoration: const BoxDecoration(
                      color: mainColor,
                      // borderRadius: BorderRadius.vertical(
                      //   bottom: Radius.circular(25),
                      // ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
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
                                '  My Shop',
                                style: TextStyle(
                                  color: backgroundColor,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
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
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: () => Jump.toArg(
                                      Pages.sellerPage,
                                      {'isRegister': user.userIsSeller},
                                    ),
                                    icon: const Icon(
                                      IconlyLight.buy,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
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
                                    child: BlurHash(
                                      hash:
                                          user.userImageHash ?? Const.emptyHash,
                                      image: user.userImage ?? Const.emptyImage,
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
                                    user.userName ?? '',
                                    style: const TextStyle(
                                      color: backgroundColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(
                                        IconlyLight.location,
                                        color: backgroundColor,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 8),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 2),
                                        child: Text(
                                          user.userCity ?? '',
                                          style: const TextStyle(
                                            color: backgroundColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: DefaultTabController(
                            length: TypeBars.bar.length,
                            child: TabBar(
                              onTap: (i) => onChangeType(i),
                              isScrollable: true,
                              physics: const BouncingScrollPhysics(),
                              indicatorSize: TabBarIndicatorSize.label,
                              labelPadding: const EdgeInsets.only(
                                left: 5,
                                right: 5,
                              ),
                              indicator: BoxDecoration(
                                color: projectWhite,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              tabs: TypeBars.bar.map((item) {
                                return CommonAnimatedSwitcher(
                                  status: selectedPage == item.index,
                                  trueWidget: CommonTabButton(
                                    textColor: mainColor,
                                    text: item.type!,
                                    color: projectWhite,
                                  ),
                                  falseWidget: CommonTabButton(
                                    textColor: projectWhite,
                                    text: item.type!,
                                    color: mainColor,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: context.width(),
                      child: Column(
                        children: [
                          Expanded(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: productStream,
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data!.docs.length > 0) {
                                    return StaggeredGridView.countBuilder(
                                      crossAxisCount: 4,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      staggeredTileBuilder: (index) =>
                                          const StaggeredTile.fit(2),
                                      padding: const EdgeInsets.only(
                                        left: 18,
                                        top: 12,
                                        right: 18,
                                      ),
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      controller: scrollController,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder: (context, index) {
                                        var query = snapshot.data.docs[index];
                                        return buildTile(
                                          query as DocumentSnapshot,
                                          deletedIndex: index,
                                        );
                                      },
                                    );
                                  } else {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: EmptyProducts(
                                            bodyColor: projectWhite,
                                            textColor: dashboardColor,
                                            onTap: () => Jump.toArg(
                                              Pages.sellerPage,
                                              {'isRegister': user.userIsSeller},
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                } else {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Flexible(
                                        child: CommonLoading(),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onChangeHandler(value) {
    const duration = Duration(milliseconds: 800);
    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping!.cancel()); // clear timer
    }
    setState(
      () => searchOnStoppedTyping = Timer(
        duration,
        () => bloc(InitShopProducts(searchCo.text.toLowerCase(), selectedType)),
      ),
    );
  }

  void onChangeType(int index) {
    setState(() {
      selectedPage = index;
      selectedType = TypeBars.bar[index].value!;
    });
    bloc(InitShopProducts(searchCo.text.toLowerCase(), selectedType));
  }

  Widget buildTile(
    DocumentSnapshot query, {
    required int deletedIndex,
  }) {
    var map = query.data() as Map<String, dynamic>;
    return deleteBuilder(
      deletedIndex: deletedIndex,
      child: ShopItems(
        model: Product.fromSearch(map),
        onDelete: () {
          context.showAlertDialog(
            onTapYes: () {
              Navigator.of(context).pop();
              bloc(DeleteProductById(Product.fromSearch(map), deletedIndex));
            },
            description: 'Deleted products cannot be restored',
            title: 'Are you sure?',
            yesText: 'Yes',
            cancelText: 'No',
          );
        },
      ),
    );
  }
}
