import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:petani_kopi/common/common_expanded.dart';
import 'package:petani_kopi/screen/dashboard/dashboard_page.dart';
import 'package:petani_kopi/theme/colors.dart';

class BottomCheckoutButton extends StatelessWidget {
  final String price;
  final String buttonText;
  final Function() onTap;
  final IconData icon;
  final Color? color;
  const BottomCheckoutButton({
    Key? key,
    required this.price,
    required this.onTap,
    this.buttonText = 'Checkout',
    this.icon = IconlyLight.buy,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ExpandableWidget(
            expand: price != '0',
            child: Visibility(
              visible: price != '0',
              child: Row(
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
                    price,
                    textAlign: TextAlign.left,
                    style: ButtomStyle().copyWith(
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => onTap(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: color ?? Colors.brown[800],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                buttonText,
                                textAlign: TextAlign.left,
                                style: ButtomStyle().copyWith(
                                  fontSize: 16,
                                ),
                              ),
                              Icon(
                                icon,
                                color: projectWhite,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
