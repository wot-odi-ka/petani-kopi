import 'package:avatar_glow/avatar_glow.dart';
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
import 'package:petani_kopi/common/common_shimmer.dart';
import 'package:petani_kopi/common/custom_dropdown.dart';
import 'package:petani_kopi/helper/app_scaler.dart';
import 'package:petani_kopi/helper/constants.dart';
import 'package:petani_kopi/model/key_val.dart';
import 'package:petani_kopi/model/order.dart';
import 'package:petani_kopi/model/order_model.dart';
import 'package:petani_kopi/screen/payment_screen/payment_item.dart';
import 'package:petani_kopi/theme/colors.dart';

class IncomingOrderItem2 extends StatefulWidget {
  final OrderSubmit model;
  const IncomingOrderItem2({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<IncomingOrderItem2> createState() => _IncomingOrderItem2State();
}

class _IncomingOrderItem2State extends State<IncomingOrderItem2> {
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

  Widget deleteBuilder({required Widget child, required int index}) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) => CommonShimmer(
        isLoading: state is OrderDeleting && index == state.index,
        child: IgnorePointer(
          ignoring: state is OrderDeleting && index == state.index,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    IconlyLight.location,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 5),
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
                    expand: widget.model.userImage != null,
                    child: Visibility(
                      visible: widget.model.userImage != null,
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
                                    child: BlurHash(
                                      hash: widget.model.userImageHash!,
                                      image: widget.model.userImage,
                                      imageFit: BoxFit.cover,
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
                                child: BlurHash(
                                  hash: widget.model.userImageHash!,
                                  image: widget.model.userImage,
                                  imageFit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: context.width(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: widget.model.processStatus != Const.done,
                          child: Expanded(
                            child: buttonBuilder(
                              index: widget.model.index ?? 0,
                              child: CustomDropDownBold(
                                hint: '',
                                varSelected: widget.model.processStatus!,
                                list: KeyOrderStatus().getList(
                                  widget.model.processStatus!,
                                ),
                                onChange: (v) {
                                  widget.model.processStatus = v;
                                  bloc(IncomingOrderUpdateStatus(widget.model));
                                },
                              ),
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
        deleteBuilder(
          index: widget.model.index ?? 0,
          child: Visibility(
            visible: widget.model.processStatus == Const.done,
            child: Positioned(
              right: 2,
              top: 2,
              child: AvatarGlow(
                glowColor: dashboardColor,
                endRadius: 30,
                duration: const Duration(milliseconds: 2000),
                repeat: true,
                showTwoGlows: true,
                repeatPauseDuration: const Duration(
                  milliseconds: 100,
                ),
                child: CircleAvatar(
                  backgroundColor: oldCoffee,
                  child: IconButton(
                    alignment: Alignment.center,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => bloc(DeleteOrderEvent(widget.model)),
                    icon: const Icon(
                      IconlyLight.buy,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
