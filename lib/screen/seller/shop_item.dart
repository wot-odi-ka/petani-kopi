import 'package:flutter/material.dart';
import 'package:petani_kopi/animation/common_detail.dart';
import 'package:petani_kopi/screen/dashboard/dasboard_detail.dart';
import 'package:petani_kopi/screen/dashboard/dashboard_page.dart';

class ShopItem extends StatefulWidget {
  const ShopItem(TabController tabController, {Key? key}) : super(key: key);

  @override
  State<ShopItem> createState() => _ShopItemState();
}

class _ShopItemState extends State<ShopItem> {
  @override
  Widget build(BuildContext context) {
    return const ShopItemBoddy();
  }
}

class ShopItemBoddy extends StatefulWidget {
  const ShopItemBoddy({Key? key}) : super(key: key);

  @override
  _ShopItemBoddyState createState() => _ShopItemBoddyState();
}

class _ShopItemBoddyState extends State<ShopItemBoddy> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  final verticalController = ScrollController();
  final horizontalController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 25,
              ),
              scrollDirection: Axis.vertical,
              controller: verticalController,
              shrinkWrap: true,
              itemCount: 12,
              itemBuilder: (ctx, index) {
                return CommonDetail(
                  item: Listgambar(isHorizontal: true),
                  page: const DasboardDetailPage(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
