import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:petani_kopi/helper/app_scaler.dart';
import 'package:petani_kopi/helper/constants.dart';
import 'package:petani_kopi/model/shoplist.dart';
import 'package:petani_kopi/theme/colors.dart';

class ShopListItem extends StatelessWidget {
  final ShopList model;
  final Function() onDelete;
  const ShopListItem({
    Key? key,
    required this.model,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: context.width(),
          child: Card(
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    child: SizedBox(
                      height: 80,
                      // width: 80,
                      child: BlurHash(
                        hash: model.userImageHash ?? '',
                        image: model.userImage ?? '',
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
                        model.userName ?? '',
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: mainColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        model.userCity ?? '',
                        style: const TextStyle(
                          fontSize: 12,
                          color: projectGray,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        ('Rp. ' + (model.totalPrice ?? '')),
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
          ),
        ),
        Positioned(
          top: -8,
          right: -3,
          child: GestureDetector(
            onTap: () => onDelete(),
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
    );
  }
}
