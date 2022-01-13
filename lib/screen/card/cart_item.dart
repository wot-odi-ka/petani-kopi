import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:iconly/iconly.dart';
import 'package:petani_kopi/bloc/cart_bloc/cart_bloc.dart';
import 'package:petani_kopi/bloc/cart_bloc/cart_event.dart';
import 'package:petani_kopi/bloc/cart_bloc/cart_state.dart';
import 'package:petani_kopi/common/common_animated_order.dart';
import 'package:petani_kopi/helper/app_scaler.dart';
import 'package:petani_kopi/helper/extension.dart';
import 'package:petani_kopi/helper/utils.dart';
import 'package:petani_kopi/model/cart_model.dart';
import 'package:petani_kopi/model/product.dart';
import 'package:petani_kopi/screen/dashboard/dashboard_page.dart';
import 'package:petani_kopi/theme/colors.dart';

class CartItemBody extends StatefulWidget {
  final CartModel model;
  final Function() onChangePrice;
  final Function(bool) onParentChecked;
  final Function(CartModel) deleteEvent;
  const CartItemBody({
    Key? key,
    required this.model,
    required this.onChangePrice,
    required this.onParentChecked,
    required this.deleteEvent,
  }) : super(key: key);

  @override
  State<CartItemBody> createState() => _CartItemBodyState();
}

class _CartItemBodyState extends State<CartItemBody> {
  bloc(CartEvent event) {
    BlocProvider.of<CartBloc>(context).add(event);
  }

  Widget blocListener({required Widget child}) => MultiBlocListener(
        child: child,
        listeners: [
          BlocListener<CartBloc, CartState>(
            listener: (context, state) {
              if (state is CartDeleted) {
                setState(() {});
                widget.deleteEvent(widget.model);
              }
            },
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return blocListener(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                padding: const EdgeInsets.all(8),
                width: context.width(),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.model.isExpand = !widget.model.isExpand!;
                        setState(() {});
                      },
                      child: Container(
                        color: projectWhite,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                              child: SizedBox(
                                height: 90,
                                width: 90,
                                child: BlurHash(
                                  hash: widget.model.shopImageHash!,
                                  image: widget.model.shopImage!,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: AnimatedColumn(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.model.shopName ?? '',
                                    // 'AJKDHASJKDHAKSJDHKJASHDKJASHDKJSAHKDSAKHDASJDJHASDKJHADSJAHSDKJSAHKDJAHKDJHASKDJHASD',
                                    style: const TextStyle(
                                      color: dashboardColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    widget.model.shopLocation ?? '',
                                    style: const TextStyle(
                                      color: dashboardColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    CartUtils.countTotal(widget.model.list!),
                                    style: const TextStyle(
                                      color: dashboardColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AnimatedColumn(
                      children: widget.model.list!.map((e) {
                        return CartExpandListItem2(
                          product: e,
                          onMin: (i) {
                            setState(() {});
                            widget.onChangePrice();
                          },
                          onSum: (i) {
                            setState(() {});
                            widget.onChangePrice();
                          },
                          onChecked: (p0) {
                            setState(() {
                              e.isChecked = p0;
                              widget.model.isChecked = widget.model.list!.any(
                                (element) => element.isChecked == true,
                              );
                            });
                            widget.onChangePrice();
                          },
                          onDelete: () {
                            widget.model.list!.removeWhere(
                              (element) => element.productId == e.productId,
                            );
                            bloc(CartListDeleteEvent(widget.model));
                          },
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 2,
            top: 2,
            child: Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              value: widget.model.isChecked,
              onChanged: (value) => widget.onParentChecked(value ?? false),
            ),
          ),
        ],
      ),
    );
  }
}

class CartExpandListItem2 extends StatefulWidget {
  final Product product;
  final Function(int) onSum;
  final Function(int) onMin;
  final Function(bool) onChecked;
  final Function() onDelete;
  const CartExpandListItem2({
    Key? key,
    required this.product,
    required this.onSum,
    required this.onMin,
    required this.onChecked,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<CartExpandListItem2> createState() => _CartExpandListItem2State();
}

class _CartExpandListItem2State extends State<CartExpandListItem2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
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
                hash: widget.product.imagesHash?[0] ?? '',
                image: widget.product.imagesUrl?[0] ?? '',
                imageFit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            widget.product.namaProduct ?? '',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: mainColor,
            ),
          ),
          subtitle: Text(
            ('Rp. ' + (widget.product.totalPrice ?? '')),
            style: const TextStyle(
              color: mainColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            value: widget.product.isChecked,
            onChanged: (c) => widget.onChecked(c!),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: projectBG.withOpacity(0.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => widget.onDelete(),
                child: const Icon(
                  IconlyLight.delete,
                  color: dashboardColor,
                ),
              ),
              const SizedBox(width: 12),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => onMin(),
                    child: Container(
                      padding: const EdgeInsets.all(4).copyWith(
                        right: 16,
                      ),
                      child: const Icon(
                        IconlyLight.arrow_left_2,
                        color: dashboardColor,
                      ),
                    ),
                  ),
                  Text(
                    widget.product.itemCount.toString(),
                    textAlign: TextAlign.left,
                    style: ButtomStyle().copyWith(
                      fontSize: 20,
                      color: dashboardColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => onSum(),
                    child: Container(
                      padding: const EdgeInsets.all(4).copyWith(
                        left: 16,
                      ),
                      child: const Icon(
                        IconlyLight.arrow_right_2,
                        color: dashboardColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void onSum() {
    int count = int.parse(widget.product.itemCount!);
    count++;
    int val = widget.product.totalPrice!.dotParse();
    int price = widget.product.hargaProduct!.dotParse();
    widget.product.totalPrice = setupSeparator(val + price);
    widget.product.itemCount = count.toString();
    widget.onSum(widget.product.totalPrice!.dotParse());
    setState(() {});
  }

  void onMin() {
    int count = int.parse(widget.product.itemCount!);
    if (count > 1) {
      count--;
      int val = widget.product.totalPrice!.dotParse();
      int price = widget.product.hargaProduct!.dotParse();
      widget.product.totalPrice = setupSeparator(val - price);
      widget.product.itemCount = count.toString();
      widget.onMin(widget.product.totalPrice!.dotParse());
      setState(() {});
    }
  }
}
