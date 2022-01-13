import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:iconly/iconly.dart';
import 'package:petani_kopi/common/common_animated_order.dart';
import 'package:petani_kopi/common/common_detail_animation.dart';
import 'package:petani_kopi/common/common_expanded.dart';
import 'package:petani_kopi/helper/app_scaler.dart';
import 'package:petani_kopi/model/cart_model.dart';
import 'package:petani_kopi/model/product.dart';
import 'package:petani_kopi/screen/dashboard/dashboard_page.dart';
import 'package:petani_kopi/theme/colors.dart';

class PaymentListBody extends StatefulWidget {
  final CartModel model;
  final Function() onTapImage;
  final Function() onTapDone;
  const PaymentListBody({
    Key? key,
    required this.model,
    required this.onTapImage,
    required this.onTapDone,
  }) : super(key: key);

  @override
  State<PaymentListBody> createState() => _PaymentListBodyState();
}

class _PaymentListBodyState extends State<PaymentListBody> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
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
                  Container(
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
                  AnimatedColumn(
                    children: widget.model.list!.map((e) {
                      return PaymentProductList(
                        product: e,
                      );
                    }).toList(),
                  ),
                  ExpandableWidget(
                    expand: widget.model.receiptFile != null,
                    child: Visibility(
                      visible: widget.model.receiptFile != null,
                      child: Column(
                        children: [
                          CommonDetailAnimation(
                            detail: Scaffold(
                              extendBodyBehindAppBar: true,
                              appBar: AppBar(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                              body: Column(
                                children: [
                                  Expanded(
                                    child: Image.file(
                                      widget.model.receiptFile ?? File(''),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: SizedBox(
                                height: 120,
                                width: context.width(),
                                child: Image.file(
                                  widget.model.receiptFile ?? File(''),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -18,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => widget.onTapImage(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.brown[800],
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Receipt',
                            textAlign: TextAlign.left,
                            style: ButtomStyle().copyWith(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            IconlyLight.image,
                            color: projectWhite,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: widget.model.receiptFile != null
                      ? () => widget.onTapDone()
                      : () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: widget.model.receiptFile != null
                          ? Colors.brown[800]
                          : Colors.grey.shade600,
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Done',
                            textAlign: TextAlign.left,
                            style: ButtomStyle().copyWith(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.check,
                            color: projectWhite,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PaymentProductList extends StatefulWidget {
  final Product product;
  const PaymentProductList({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<PaymentProductList> createState() => _PaymentProductListState();
}

class _PaymentProductListState extends State<PaymentProductList> {
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
        ),
      ],
    );
  }
}
