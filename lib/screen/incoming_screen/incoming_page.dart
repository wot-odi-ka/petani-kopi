import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:petani_kopi/bloc/order_bloc/order_bloc.dart';
import 'package:petani_kopi/bloc/order_bloc/order_event.dart';
import 'package:petani_kopi/bloc/order_bloc/order_state.dart';
import 'package:petani_kopi/common/common_empty_shop.dart';
import 'package:petani_kopi/common/common_loading.dart';
import 'package:petani_kopi/helper/app_scaler.dart';
import 'package:petani_kopi/helper/page.dart';
import 'package:petani_kopi/helper/snack_bar.dart';
import 'package:petani_kopi/model/order_model.dart';
import 'package:petani_kopi/screen/incoming_screen/incoming_item.dart';
import 'package:petani_kopi/service/jump.dart';
import 'package:petani_kopi/theme/colors.dart';

class IncomingOrderPage extends StatelessWidget {
  const IncomingOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OrderBloc>(
          create: (context) => OrderBloc()..add(InitGetIncomingOrder()),
        ),
      ],
      child: const IncomingOrderBody(),
    );
  }
}

class IncomingOrderBody extends StatefulWidget {
  const IncomingOrderBody({Key? key}) : super(key: key);

  @override
  _IncomingOrderBodyState createState() => _IncomingOrderBodyState();
}

class _IncomingOrderBodyState extends State<IncomingOrderBody> {
  ScrollController scrollController = ScrollController();
  Stream<QuerySnapshot>? orderStream;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  bloc(OrderEvent event) {
    BlocProvider.of<OrderBloc>(context).add(event);
  }

  Widget blocListener({required Widget child}) => MultiBlocListener(
        child: child,
        listeners: [
          BlocListener<OrderBloc, OrderState>(
            listener: (context, state) {
              if (state is InitGetIncomingLoaded) {
                setState(() {
                  orderStream = state.orderStream;
                });
              }
              if (state is OrderFailed) {
                context.fail(state.error);
              }
            },
          ),
        ],
      );

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
                      'Incoming Order',
                      style: TextStyle(
                        color: backgroundColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                          stream: orderStream,
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.docs.length > 0) {
                                return ListView.builder(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: EmptyProducts(
                                        onTap: () => Jump.to(Pages.homePage),
                                        icon: IconlyLight.arrow_left_2,
                                        text: 'Back to Home',
                                        bodyColor: projectWhite,
                                        textColor: dashboardColor,
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
                                    child: CommonLoading(
                                      color: projectWhite,
                                    ),
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
    );
  }

  Widget buildTile(
    DocumentSnapshot query, {
    required int deletedIndex,
  }) {
    var map = query.data() as Map<String, dynamic>;
    var orders = Order.incoming(map);
    orders.index = deletedIndex;
    return IncomingOrderItem(
      model: orders,
    );
  }
}
