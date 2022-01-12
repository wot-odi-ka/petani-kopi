import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:iconly/iconly.dart';
import 'package:petani_kopi/bloc/dasboard_bloc/dasboard_bloc.dart';
import 'package:petani_kopi/bloc/dasboard_bloc/dasboard_event.dart';
import 'package:petani_kopi/bloc/dasboard_bloc/dasboard_state.dart';
import 'package:petani_kopi/common/common_carousel.dart';
import 'package:petani_kopi/common/common_detail_animation.dart';
import 'package:petani_kopi/common/common_expanded.dart';
import 'package:petani_kopi/common/common_loading.dart';
import 'package:petani_kopi/common/common_shimmer.dart';
import 'package:petani_kopi/helper/app_scaler.dart';
import 'package:petani_kopi/helper/constants.dart';
import 'package:petani_kopi/helper/page.dart';
import 'package:petani_kopi/helper/snack_bar.dart';
import 'package:petani_kopi/helper/utils.dart';
import 'package:petani_kopi/model/product.dart';
import 'package:petani_kopi/model/users.dart';
import 'package:petani_kopi/service/jump.dart';
import 'package:petani_kopi/theme/colors.dart';

import 'dashboard_page.dart';

class DashboardItemDetail extends StatelessWidget {
  final Product model;
  const DashboardItemDetail({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DasboardBloc>(
      create: (context) => DasboardBloc()..add(DasboardViewEvent(model)),
      child: const DashboardItemDetailBody(),
    );
  }
}

class DashboardItemDetailBody extends StatefulWidget {
  const DashboardItemDetailBody({Key? key}) : super(key: key);

  @override
  _DashboardItemDetailBodyState createState() =>
      _DashboardItemDetailBodyState();
}

class _DashboardItemDetailBodyState extends State<DashboardItemDetailBody>
    with TickerProviderStateMixin {
  Product product = Product();
  int itemCount = 1;
  int oldPrice = 0;
  ScrollController scrollController = ScrollController();
  late PageController _pageController;
  late AnimationController animation;
  List<CarouselUri> images = [];

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

  Widget blocListener({required Widget child}) {
    return BlocListener<DasboardBloc, DasboardState>(
      listener: (context, state) {
        if (state is GetProductSucsess) {
          product = state.products;
          oldPrice = int.parse(product.hargaProduct!.replaceAll('.', ''));
          for (var i = 0; i < product.imagesUrl!.length; i++) {
            CarouselUri arg = CarouselUri();
            arg.index = i;
            arg.image = product.imagesUrl![i];
            arg.hash = product.imagesHash![i];
            images.add(arg);
          }
          setState(() {});
        }
        if (state is AddCartSubmitted) {
          Jump.replace(Pages.homePage);
        }
        if (state is DasboardFiled) {
          context.fail(state.error);
        }
      },
      child: child,
    );
  }

  Widget bodyBuilder({required Widget child}) {
    return BlocBuilder<DasboardBloc, DasboardState>(
      builder: (context, state) {
        if (state is DasboardOnlodingState) {
          return const CommonLoading();
        } else {
          return child;
        }
      },
    );
  }

  Widget buttonBuilder({required Widget child}) {
    return BlocBuilder<DasboardBloc, DasboardState>(
      builder: (context, state) => CommonShimmer(
        child: child,
        isLoading: state is AddCartSubmittin,
      ),
    );
  }

  Users users() {
    return BlocProvider.of<DasboardBloc>(context).user;
  }

  bloc(DasboardEvent event) {
    BlocProvider.of<DasboardBloc>(context).add(event);
  }

  @override
  Widget build(BuildContext context) {
    return blocListener(
      child: bodyBuilder(
        child: Scaffold(
          backgroundColor: const Color(0xFF0d1015),
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Color(0xFF0d1015),
            ),
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: projectWhite,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => decrementPrice(),
                            child: Container(
                              padding: const EdgeInsets.all(4).copyWith(
                                right: 16,
                              ),
                              child: const Icon(IconlyLight.arrow_left_2),
                            ),
                          ),
                          Text(
                            itemCount.toString(),
                            textAlign: TextAlign.left,
                            style: ButtomStyle().copyWith(
                              fontSize: 20,
                              color: const Color(0xFF0d1015),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => incrementPrice(),
                            child: Container(
                              padding: const EdgeInsets.all(4).copyWith(
                                left: 16,
                              ),
                              child: const Icon(IconlyLight.arrow_right_2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "IDR",
                          textAlign: TextAlign.left,
                          style: ButtomStyle().copyWith(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          product.hargaProduct ?? '',
                          textAlign: TextAlign.left,
                          style: ButtomStyle().copyWith(
                            fontSize: 28,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: buttonBuilder(
                        child: GestureDetector(
                          onTap: () => onSubmit(),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.brown[800],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 2.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Add to Cart',
                                    textAlign: TextAlign.left,
                                    style: ButtomStyle().copyWith(
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Icon(
                                    IconlyLight.buy,
                                    color: projectWhite,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
          body: bodyBuilder(
            child: SizedBox(
              height: context.height(),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: context.width(),
                      decoration: const BoxDecoration(
                        color: Color(0xFF0d1015),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(40),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.brown[800],
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                  ),
                                  child: Text(
                                    product.jenisKopi ?? '',
                                    textAlign: TextAlign.left,
                                    style: ButtomStyle().copyWith(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Text(
                              product.namaProduct ?? '',
                              style: headerStyle(),
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
                                  padding: const EdgeInsets.only(bottom: 2),
                                  child: Text(
                                    product.userCity ?? '',
                                    style: const TextStyle(
                                      color: backgroundColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ExpandableWidget(
                              expand: images.isNotEmpty,
                              child: Column(
                                children: [
                                  const SizedBox(height: 24),
                                  SizedBox(
                                    height: 220,
                                    child: PageView.builder(
                                      itemCount: images.length,
                                      controller: _pageController,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return CommonUriCarousel(
                                          controller: _pageController,
                                          animation: animation,
                                          model: images[index],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0).copyWith(top: 0),
                      child: Text(
                        product.descProduct ?? '',
                        style: const TextStyle(
                          color: backgroundColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
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
    Product submit = product;
    int total = int.parse(product.hargaProduct!.replaceAll('.', ''));
    submit.totalPrice = setupSeparator(total);
    submit.hargaProduct = setupSeparator(oldPrice);
    submit.itemCount = itemCount.toString();
    bloc(AddToCartEvent(submit));
  }

  incrementPrice() {
    int current = int.parse(product.hargaProduct!.replaceAll('.', ''));
    int increment = current + oldPrice;
    product.hargaProduct = setupSeparator(increment);
    itemCount++;
    setState(() {});
  }

  decrementPrice() {
    if (itemCount == 1) {
      return;
    } else {
      int current = int.parse(product.hargaProduct!.replaceAll('.', ''));
      int decrement = current - oldPrice;
      product.hargaProduct = setupSeparator(decrement);
      itemCount--;
      setState(() {});
    }
  }
}
