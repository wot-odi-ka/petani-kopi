import 'package:flutter/material.dart';
import 'package:petani_kopi/common/common_animated_order.dart';
import 'package:petani_kopi/model/product.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:petani_kopi/theme/colors.dart';

class ShopItems extends StatelessWidget {
  final Product model;
  final Function() onDelete;
  const ShopItems({
    Key? key,
    required this.model,
    required this.onDelete,
  }) : super(key: key);

  get commonShadow => null;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          elevation: 10,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: AnimatedColumn(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: SizedBox(
                  height: 180,
                  child: BlurHash(
                    hash: model.imagesHash?[0] ?? '',
                    image: model.imagesUrl?[0] ?? '',
                    imageFit: BoxFit.cover,
                  ),
                ),
              ),
              Material(
                elevation: 10,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(8),
                ),
                child: Container(
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
                        model.namaProduct ?? '',
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: mainColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        model.descProduct ?? '',
                        style: const TextStyle(
                          fontSize: 12,
                          color: projectGray,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        ('Rp. ' + (model.hargaProduct ?? '')),
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
              ),
            ],
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => onDelete(),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: backgroundColor.withOpacity(0.7),
                boxShadow: commonShadow,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
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
