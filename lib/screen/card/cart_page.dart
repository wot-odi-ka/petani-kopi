import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:petani_kopi/bloc/cart_bloc/cart_bloc.dart';
import 'package:petani_kopi/bloc/cart_bloc/cart_event.dart';
import 'package:petani_kopi/bloc/cart_bloc/cart_state.dart';
import 'package:petani_kopi/common/common_alert_dialog.dart';
import 'package:petani_kopi/common/common_empty_shop.dart';
import 'package:petani_kopi/common/common_loading.dart';
import 'package:petani_kopi/helper/app_scaler.dart';
import 'package:petani_kopi/helper/page.dart';
import 'package:petani_kopi/model/shoplist.dart';
import 'package:petani_kopi/screen/card/cart_page_item.dart';
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
                  shopStream = state.shops;
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
        body: bodyBuilder(
          child: SizedBox(
            height: context.height(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Expanded(
                  child: SizedBox(
                    width: context.width(),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: shopStream,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.docs.length > 0) {
                            return StaggeredGridView.countBuilder(
                              crossAxisCount: 4,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              staggeredTileBuilder: (index) =>
                                  const StaggeredTile.fit(4),
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
    return ShopListItem(
      model: ShopList.map(map),
      onDelete: () {
        context.showAlertDialog(
          onTapYes: () {
            Navigator.of(context).pop();
            // bloc(DeleteProductById(Product.fromSearch(map), deletedIndex));
          },
          description: 'Deleted items cannot be restored',
          title: 'Are you sure?',
          yesText: 'Yes',
          cancelText: 'No',
        );
      },
    );
  }
}
