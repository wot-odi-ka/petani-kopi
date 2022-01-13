import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:iconly/iconly.dart';
import 'package:petani_kopi/bloc/cart_bloc/cart_bloc.dart';
import 'package:petani_kopi/bloc/cart_bloc/cart_event.dart';
import 'package:petani_kopi/bloc/cart_bloc/cart_state.dart';
import 'package:petani_kopi/common/common_detail_animation.dart';
import 'package:petani_kopi/common/common_empty_shop.dart';
import 'package:petani_kopi/common/common_loading.dart';
import 'package:petani_kopi/helper/app_scaler.dart';
import 'package:petani_kopi/model/orderitemlist.dart';
import 'package:petani_kopi/model/product.dart';
import 'package:petani_kopi/model/shoplist.dart';
import 'package:petani_kopi/screen/card/cart_expand_item.dart';
import 'package:petani_kopi/screen/dashboard/dashboard_item_detail.dart';
import 'package:petani_kopi/screen/dashboard/dashboard_page.dart';
import 'package:petani_kopi/theme/colors.dart';

class OrderExpandItem extends StatelessWidget {
  final ShopList model;
  final Function(String) onSum;
  const OrderExpandItem({
    Key? key,
    required this.model,
    required this.onSum,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartBloc>(
      create: (context) => CartBloc()..add(GetCartItem(model)),
      child: CartExpandItemBody(onSum: onSum),
    );
  }
}

class OrderExpandItemBoddy extends StatefulWidget {
  final Function(String) onSum;
  const OrderExpandItemBoddy({Key? key, required this.onSum}) : super(key: key);

  @override
  _OrderExpandItemBoddyState createState() => _OrderExpandItemBoddyState();
}

class _OrderExpandItemBoddyState extends State<OrderExpandItemBoddy> {
  Stream<QuerySnapshot>? shopStream;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Widget blocListener({required Widget child}) => MultiBlocListener(
        child: child,
        listeners: [
          BlocListener<CartBloc, CartState>(
            listener: (context, state) {
              if (state is CartItemLoaded) {
                setState(() {
                  shopStream = state.carts;
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
      child: SizedBox(
        width: context.width(),
        height: context.height() * 0.35,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
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
          ],
        ),
      ),
    );
  }

  Widget buildTile(
    DocumentSnapshot query, {
    required int deletedIndex,
  }) {
    var map = query.data() as Map<String, dynamic>;
    return CommonDetailAnimation(
      color: Colors.transparent,
      detail: DashboardItemDetail(model: Product.fromSearch(map)),
      child: CartExpandListItem(product: Product.fromCart(map)),
    );
  }
}

class CartExpandListItem extends StatelessWidget {
  final Product product;
  const CartExpandListItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      leading: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        child: SizedBox(
          height: 45,
          width: 45,
          child: BlurHash(
            hash: product.imagesHash?[0] ?? '',
            image: product.imagesUrl?[0] ?? '',
            imageFit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        product.namaProduct ?? '',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: mainColor,
        ),
      ),
      subtitle: Text(
        ('Rp. ' + (product.hargaProduct ?? '')),
        style: const TextStyle(
          color: mainColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(4).copyWith(
                      right: 16,
                    ),
                    child: const Icon(IconlyLight.arrow_left_2),
                  ),
                ),
                Text(
                  product.itemCount.toString(),
                  textAlign: TextAlign.left,
                  style: ButtomStyle().copyWith(
                    fontSize: 20,
                    color: const Color(0xFF0d1015),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(4).copyWith(
                      left: 16,
                    ),
                    child: const Icon(IconlyLight.arrow_right_2),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
