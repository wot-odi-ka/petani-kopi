import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:iconly/iconly.dart';
import 'package:petani_kopi/bloc/order_bloc/order_bloc.dart';
import 'package:petani_kopi/bloc/order_bloc/order_event.dart';
import 'package:petani_kopi/bloc/order_bloc/order_state.dart';
import 'package:petani_kopi/common/common_animated_order.dart';
import 'package:petani_kopi/common/common_detail_animation.dart';
import 'package:petani_kopi/common/common_expanded.dart';
import 'package:petani_kopi/common/common_profile_tile.dart';
import 'package:petani_kopi/common/common_shimmer.dart';
import 'package:petani_kopi/common/custom_dropdown.dart';
import 'package:petani_kopi/helper/app_scaler.dart';
import 'package:petani_kopi/model/cart_model.dart';
import 'package:petani_kopi/model/key_val.dart';
import 'package:petani_kopi/model/order_model.dart';
import 'package:petani_kopi/model/product.dart';
import 'package:petani_kopi/screen/dashboard/dashboard_page.dart';
import 'package:petani_kopi/screen/payment_screen/payment_item.dart';
import 'package:petani_kopi/theme/colors.dart';

class IncomingOrderItem extends StatefulWidget {
  final Order model;
  const IncomingOrderItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<IncomingOrderItem> createState() => _IncomingOrderItemState();
}

class _IncomingOrderItemState extends State<IncomingOrderItem> {
  bloc(OrderEvent event) {
    BlocProvider.of<OrderBloc>(context).add(event);
  }

  Widget buttonBuilder({required Widget child, required int index}) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) => CommonShimmer(
        isLoading: state is IncomingUpdating && index == state.index,
        child: IgnorePointer(
          ignoring: state is IncomingUpdating && index == state.index,
          child: child,
        ),
      ),
    );
  }

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
                              hash: widget.model.userImageHash!,
                              image: widget.model.userImage!,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AnimatedColumn(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.model.userName ?? '',
                                style: const TextStyle(
                                  color: dashboardColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                widget.model.userLocation ?? '',
                                style: const TextStyle(
                                  color: dashboardColor,
                                  fontSize: 14,
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
                  SizedBox(
                    width: context.width(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: buttonBuilder(
                            index: widget.model.index ?? 0,
                            child: CustomDropDownBold(
                              varSelected: widget.model.userStatus!,
                              list: KeyOrderStatus().getList(
                                widget.model.userStatus!,
                              ),
                              hint: '',
                              onChange: (v) {
                                widget.model.userStatus = v;
                                bloc(IncomingOrderUpdateStatus(widget.model));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
