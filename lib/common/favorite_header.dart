// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:petani_kopi/screen/dashboard/dashboard_page.dart';

class FavoriteHeader extends StatelessWidget {
  const FavoriteHeader({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
    this.price,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String image;
  final double? price;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Column(
        children: [
          Visibility(
            visible: true,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(40), bottom: Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 5),
                    )
                  ]),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(60), bottom: Radius.circular(60)),
                    child: Image.asset(
                      'assets/images/kopiHitam.png',
                      alignment: Alignment.centerRight,
                      filterQuality: FilterQuality.high,
                      height: 150,
                      width: 200,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  // Padding(padding: EdgeInsets.only(top: 10)),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Kopi Ireng',
                          style: ButtomStyle(),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Biji Kopi Asli',
                        style: cardStyle(),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '\$4.59',
                        style: ButtomStyle(),
                      )
                    ],
                  ),
                  // Column(
                  //   children: [
                  //     Align(
                  //       alignment: Alignment.centerLeft,
                  //       child: Text(
                  //         'Biji Kopi Asli',
                  //         style: cardStyle(),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // // Padding(padding: EdgeInsets.only(top: 2)),
                  // Column(
                  //   children: [
                  //     Align(
                  //       alignment: Alignment.centerLeft,
                  //       child: Text(
                  //         '\$4.59',
                  //         style: ButtomStyle(),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
