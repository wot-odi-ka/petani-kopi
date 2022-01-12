import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:petani_kopi/bloc/my_order_bloc/my_order_bloc.dart';
import 'package:petani_kopi/bloc/my_order_bloc/my_order_event.dart';
import 'package:petani_kopi/bloc/my_order_bloc/my_order_state.dart';
import 'package:petani_kopi/common/common_loading.dart';
import 'package:petani_kopi/common/keep_alive.dart';
import 'package:petani_kopi/helper/app_scaler.dart';
import 'package:petani_kopi/helper/constants.dart';
import 'package:petani_kopi/helper/snack_bar.dart';
import 'package:petani_kopi/model/users.dart';
import 'package:petani_kopi/screen/seller/produk_pesanan_keluar.dart';
import 'package:petani_kopi/screen/seller/produk_pesanan_masuk.dart';
import 'package:petani_kopi/service/jump.dart';
import 'package:petani_kopi/theme/colors.dart';

class MyOrderPage extends StatelessWidget {
  const MyOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<MyOrderBloc>(
          create: (context) => MyOrderBloc()..add(InitialMyOrderEvent())),
    ], child: const MayOrderBody());
  }
}

class MayOrderBody extends StatefulWidget {
  const MayOrderBody({Key? key}) : super(key: key);

  @override
  _MayOrderBodyState createState() => _MayOrderBodyState();
}

class _MayOrderBodyState extends State<MayOrderBody>
    with TickerProviderStateMixin {
  Users user = Users();
  late TabController tabController;
  int selectedIndex = 1;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    tabController.addListener(onChangeIndex);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  onChangeIndex() {
    if (tabController.indexIsChanging) {
      selectedIndex = tabController.index;
      setState(() {});
    }
  }

  bloc(MyOrderEvent event) {
    BlocProvider.of<MyOrderBloc>(context).add(event);
  }

  Widget blocListener({required Widget child}) {
    return MultiBlocListener(
      child: child,
      listeners: [
        BlocListener<MyOrderBloc, MyOrderState>(
          listener: (context, state) {
            if (state is InitMyOrderDone) {
              setState(() {
                user = state.user;
              });
            }
            if (state is MyOrderFiled) {
              context.fail(state.error);
            }
          },
        ),
      ],
    );
  }

  Widget blocBuilder({required Widget child}) {
    return BlocBuilder<MyOrderBloc, MyOrderState>(
      builder: (context, state) {
        if (state is InitialMyOrderLoading || state is MyOrderInitial) {
          return const CommonLoading();
        } else {
          return child;
        }
      },
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
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 35),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                '  My Order',
                                style: TextStyle(
                                  color: backgroundColor,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                  child: SizedBox(
                                    width: 80.0,
                                    height: 80.0,
                                    child: BlurHash(
                                      color: mainColor,
                                      hash:
                                          user.userImageHash ?? Const.emptyHash,
                                      image: user.userImage ?? Const.emptyImage,
                                      imageFit: BoxFit.cover,
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
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      user.userName ?? '',
                                      style: const TextStyle(
                                        color: backgroundColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: Container(
                      width: context.width(),
                      decoration: const BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(8),
                              ),
                            ),
                            child: TabBar(
                              controller: tabController,
                              indicatorColor: Colors.transparent,
                              unselectedLabelColor: mainColor,
                              indicator: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              labelColor: backgroundColor,
                              tabs: const [
                                Tab(
                                  child: Center(child: Text('Pesanan Masuk')),
                                ),
                                Tab(
                                  child: Center(child: Text('Pesanan Keluar')),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: tabController,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                KeepAlivePage(
                                  child: PesananMasukPage(tabController),
                                ),
                                KeepAlivePage(
                                  child: ProdukPesananKeluar(tabController),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
