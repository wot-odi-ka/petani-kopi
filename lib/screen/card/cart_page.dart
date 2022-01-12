import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconly/iconly.dart';
import 'package:petani_kopi/bloc/cart_bloc/cart_bloc.dart';
import 'package:petani_kopi/bloc/cart_bloc/cart_event.dart';
import 'package:petani_kopi/bloc/cart_bloc/cart_state.dart';
import 'package:petani_kopi/common/common_alert_dialog.dart';
import 'package:petani_kopi/common/common_empty_shop.dart';
import 'package:petani_kopi/common/common_expanded.dart';
import 'package:petani_kopi/common/common_loading.dart';
import 'package:petani_kopi/helper/app_scaler.dart';
import 'package:petani_kopi/helper/page.dart';
import 'package:petani_kopi/model/cart_model.dart';
import 'package:petani_kopi/model/shoplist.dart';
import 'package:petani_kopi/screen/card/cart_item.dart';
import 'package:petani_kopi/screen/card/cart_page_item.dart';
import 'package:petani_kopi/screen/dashboard/dashboard_page.dart';
import 'package:petani_kopi/service/jump.dart';
import 'package:petani_kopi/theme/colors.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartBloc>(
      create: (context) => CartBloc()..add(InitCartShopList()),
      child: const CartBody(),
    );
  }
}

class CartBody extends StatefulWidget {
  const CartBody({Key? key}) : super(key: key);

  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  List<CartModel> cartList = [];
  List<CartModel> checkedCartList = [];
  ScrollController scrollController = ScrollController();
  Stream<QuerySnapshot>? shopStream;

  @override
  void initState() {
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

  Widget blocListener({required Widget child}) => MultiBlocListener(
        child: child,
        listeners: [
          BlocListener<CartBloc, CartState>(
            listener: (context, state) {
              if (state is InitCartLoaded) {
                setState(() {
                  // shopStream = state.shops;
                  cartList.clear();
                  cartList.addAll(state.carts);
                });
              }
            },
          ),
        ],
      );

  Widget bodyBuilder({required Widget child}) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is InitCartOnLoading) {
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
        backgroundColor: dashboardColor,
        bottomNavigationBar: bottomSheet(),
        body: bodyBuilder(
          child: SizedBox(
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
                        'My Cart',
                        style: TextStyle(
                          color: backgroundColor,
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: ExpandableWidget(
                    expand: cartList.isNotEmpty,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: cartList.length,
                      shrinkWrap: true,
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CartItemBody(
                          model: cartList[index],
                          onParentChecked: (val) => onParentChecked(
                            cartList[index],
                            val,
                          ),
                          onChangePrice: () => setState(() {}),
                          deleteEvent: (model) {
                            if (model.list!.isEmpty) {
                              cartList.removeWhere(
                                  (element) => element.shopId == model.shopId);
                              setState(() {});
                            }
                          },
                        );
                      },
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

  Widget bottomSheet() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
                CartUtils.countCheckout(checkedCartList),
                textAlign: TextAlign.left,
                style: ButtomStyle().copyWith(
                  fontSize: 28,
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Checkout',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  onParentChecked(CartModel model, bool val) {
    model.isChecked = val;
    if (val) {
      for (var element in model.list!) {
        element.isChecked = true;
      }
      checkedCartList.add(model);
    } else {
      for (var element in model.list!) {
        element.isChecked = false;
      }
      checkedCartList.removeWhere(
        (element) => element.shopId == model.shopId,
      );
    }
    setState(() {});
  }
}
