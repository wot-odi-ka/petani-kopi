import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:petani_kopi/common/common_expanded.dart';
import 'package:petani_kopi/helper/app_scaler.dart';
import 'package:petani_kopi/model/shoplist.dart';
import 'package:petani_kopi/screen/card/cart_expand_item.dart';
import 'package:petani_kopi/theme/colors.dart';

class MyOrderItem extends StatefulWidget {
  final ShopList model;
  final Function() onDelete;
  final Function() onTapItem;
  const MyOrderItem({
    Key? key,
    required this.model,
    required this.onDelete,
    required this.onTapItem,
  }) : super(key: key);

  @override
  _MyOrderItemState createState() => _MyOrderItemState();
}

class _MyOrderItemState extends State<MyOrderItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.model.isExpand =
            widget.model.isExpand != null ? !widget.model.isExpand! : false;
        setState(() {});
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: context.width(),
            child: Card(
              elevation: 10,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          child: SizedBox(
                            height: 95,
                            //width: 80,
                            child: BlurHash(
                              hash: widget.model.userImageHash ?? '',
                              image: widget.model.userImage ?? '',
                              imageFit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 3,
                        ),
                        decoration: const BoxDecoration(
                          color: projectWhite,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(8),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              widget.model.userName ?? '',
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                                color: mainColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.model.userCity ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                                color: projectGray,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              ('Rp. ' + (widget.model.totalPrice ?? '')),
                              style: const TextStyle(
                                color: mainColor,
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ExpandableWidget(
                    expand: widget.model.isExpand ?? false,
                    child: Visibility(
                      visible: widget.model.isExpand ?? false,
                      child: CartExpandItem(
                        model: widget.model,
                        onSum: (val) {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -8,
            right: -3,
            child: GestureDetector(
              onTap: () => widget.onDelete(),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: backgroundColor.withOpacity(0.7),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: const Icon(
                  Icons.close_rounded,
                  color: mainColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
