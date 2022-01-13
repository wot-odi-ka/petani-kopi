// ignore_for_file: prefer_const_constructors, avoid_print, avoid_unnecessary_containers, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconly/iconly.dart';
import 'package:petani_kopi/bloc/dasboard_bloc/dasboard_bloc.dart';
import 'package:petani_kopi/bloc/dasboard_bloc/dasboard_event.dart';
import 'package:petani_kopi/bloc/dasboard_bloc/dasboard_state.dart';
import 'package:petani_kopi/common/common_animated_switcher.dart';
import 'package:petani_kopi/common/common_detail_animation.dart';
import 'package:petani_kopi/common/common_empty_shop.dart';
import 'package:petani_kopi/common/common_loading.dart';
import 'package:petani_kopi/common/common_tab_button.dart';
import 'package:petani_kopi/helper/app_scaler.dart';
import 'package:petani_kopi/helper/page.dart';
import 'package:petani_kopi/model/product.dart';
import 'package:petani_kopi/model/typebar_model.dart';
import 'package:petani_kopi/model/users.dart';
import 'package:petani_kopi/screen/dashboard/dashboard_item_detail.dart';
import 'package:petani_kopi/screen/dashboard/dashboard_items.dart';
import 'package:petani_kopi/service/jump.dart';
import 'package:petani_kopi/theme/colors.dart';

import 'dasboard_widgets.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DasboardBloc()..add(DasboardInitialEvent('', '')),
      child: DashboardBody(),
    );
  }
}

class DashboardBody extends StatefulWidget {
  const DashboardBody({Key? key}) : super(key: key);

  @override
  _DashboardBodyState createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  final verticalController = ScrollController();
  final horizontalController = ScrollController();
  Timer? searchOnStoppedTyping;
  TextEditingController searchCo = TextEditingController();
  FocusNode searchNode = FocusNode();
  Stream<QuerySnapshot>? productStream;
  int selectedPage = 0;
  String selectedType = '';
  String searchVal = '';

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {});
    super.initState();
  }

  Widget blocListener({required Widget child}) {
    return BlocListener<DasboardBloc, DasboardState>(
      listener: (context, state) {
        if (state is DasboardOnloadedState) {
          setState(() {
            productStream = state.products;
          });
        }
      },
      child: child,
    );
  }

  Users users() {
    return BlocProvider.of<DasboardBloc>(context).user;
  }

  bloc(DasboardEvent event) {
    BlocProvider.of<DasboardBloc>(context).add(event);
  }

  Users user() {
    return BlocProvider.of<DasboardBloc>(context).user;
  }

  onChangeHandler(value) {
    const duration = Duration(milliseconds: 800);
    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping!.cancel());
    }
    setState(() => searchOnStoppedTyping =
        Timer(duration, () => bloc(DasboardInitialEvent(value, selectedType))));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: blocListener(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xFF0d1015),
            automaticallyImplyLeading: false,
            actions: [
              Center(
                child: Stack(
                  children: [
                    IconButton(
                      color: Colors.white,
                      iconSize: 25,
                      onPressed: () {
                        Jump.to(Pages.notivication);
                      },
                      icon: Icon(Icons.add_alert_rounded),
                    ),
                    Visibility(
                      visible: true,
                      child: Positioned(
                        top: 1,
                        right: 5,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Text(
                            3.toString(),
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
          backgroundColor: Color(0xFF0d1015),
          body: SizedBox(
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Find the best',
                              style: headerStyle(),
                            ),
                            Text(
                              'coffee for you',
                              style: headerStyle(),
                            ),
                            SizedBox(height: 30),
                            // const SizedBox(height: 24),
                            DashboardField(
                              hint: 'Find Your Coffee...',
                              borderColor: Color(0xFF161922),
                              controller: searchCo,
                              onChange: (p0) => onChangeHandler(p0),
                              prefixIcon: Icon(
                                IconlyLight.search,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
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
                                  return NotificationListener<
                                      ScrollNotification>(
                                    onNotification: (scrollNotification) {
                                      if (scrollNotification
                                          is ScrollUpdateNotification) {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      }
                                      return true;
                                    },
                                    child: StaggeredGridView.countBuilder(
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
                                      controller: verticalController,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder: (context, index) {
                                        var query = snapshot.data.docs[index];
                                        return buildTile(
                                          query as DocumentSnapshot,
                                          deletedIndex: index,
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: EmptyProducts(
                                          text: 'No product yet',
                                          icon: IconlyLight.info_circle,
                                          onTap: () {},
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
    );
  }

  Widget buildTile(
    DocumentSnapshot query, {
    required int deletedIndex,
  }) {
    var map = query.data() as Map<String, dynamic>;
    return Visibility(
      visible: user().userId != map['userId'],
      child: CommonDetailAnimation(
        color: Colors.transparent,
        detail: DashboardItemDetail(model: Product.fromSearch(map)),
        child: DashboardItems(model: Product.fromCart(map)),
      ),
    );
  }

  void onChangeType(int index) {
    setState(() {
      selectedPage = index;
      selectedType = TypeBars.bar[index].value!;
    });
    bloc(DasboardInitialEvent('', selectedType));
  }
}

TextStyle headerStyle() {
  return const TextStyle(
    fontSize: 30,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
}

TextStyle ButtomStyle() {
  return TextStyle(
    fontSize: 15,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
}

TextStyle cardStyle() {
  return TextStyle(
    fontSize: 10,
    color: Colors.white,
    fontWeight: FontWeight.normal,
  );
}

TextStyle ListStyle() {
  return TextStyle(
    fontSize: 15,
    color: Colors.brown.shade400,
    fontWeight: FontWeight.bold,
  );
}

Widget Listgambar({required bool isHorizontal}) {
  return AspectRatio(
    aspectRatio: 2,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Visibility(
            visible: isHorizontal,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10), bottom: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 5),
                    )
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20), bottom: Radius.circular(20)),
                    child: Image.asset(
                      'assets/images/kopiHitam.png',
                      alignment: Alignment.center,
                      filterQuality: FilterQuality.high,
                      height: 80,
                    ),
                  ),
                  // Padding(padding: EdgeInsets.only(top: 10)),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Kopi Ireng',
                      style: ButtomStyle(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Biji Kopi Asli',
                      style: cardStyle(),
                    ),
                  ),
                  // Padding(padding: EdgeInsets.only(top: 2)),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Rp.4.59',
                      style: ButtomStyle(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
