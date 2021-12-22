import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petani_kopi/common/keep_alive.dart';
import 'package:petani_kopi/helper/app_scaler.dart';

import 'package:petani_kopi/helper/page.dart';
import 'package:petani_kopi/screen/login/login_screen.dart';
import 'package:petani_kopi/screen/login/register_page.dart';
import 'package:petani_kopi/screen/seller/product_pesanan.dart';
import 'package:petani_kopi/screen/seller/shop_item.dart';

import 'package:petani_kopi/service/jump.dart';
import 'package:petani_kopi/theme/colors.dart';

class MyShopPage extends StatelessWidget {
  const MyShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyshopeBoddy();
  }
}

class MyshopeBoddy extends StatefulWidget {
  const MyshopeBoddy({Key? key}) : super(key: key);

  @override
  _MyshopeBoddyState createState() => _MyshopeBoddyState();
}

class _MyshopeBoddyState extends State<MyshopeBoddy>
    with TickerProviderStateMixin {
  bool isLoading = false;
  late Timer? timer;

  produk() {
    setState(() {
      isLoading = true;
    });
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          isLoading = false;
          timer.cancel();
          Jump.replace(Pages.tambahProduct);
        });
      },
    );
  }

  late TabController tabController;
  int selectedIndex = 1;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    tabController.addListener(onChangeIndex);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  onChangeIndex() {
    if (tabController.indexIsChanging) {
      selectedIndex = tabController.index;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0d1015),
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Jump.replace(Pages.profilPage);
          },
        ),
        title: const Text(
          'My Shop',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        actions: [
          MaterialButton(
            onPressed: isLoading
                ? null
                : () {
                    produk();
                  },
            height: 10,
            padding: const EdgeInsets.all(
              10,
            ),
            elevation: 0,
            splashColor: Colors.yellow[700],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: const Color(0xFF0d1015),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        strokeWidth: 3,
                        color: Colors.black,
                      ),
                    )
                  : const Text(
                      "Tambah Produk",
                      style: TextStyle(color: Colors.brown, fontSize: 15),
                    ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                const SizedBox(width: 20.0),
                const SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey,
                        child: CircleAvatar(
                            radius: 35.0,
                            backgroundImage:
                                AssetImage('assets/images/kopiHitam.png')))),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Jajat_Shop",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0),
                    const Text("Rumah Kopi Bogor"),
                    const SizedBox(height: 5.0),
                    Row(
                      children: const <Widget>[
                        Icon(
                          Icons.map,
                          size: 12.0,
                          color: Colors.black54,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          "Bogor, Indonesia",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                width: context.width(),
                decoration: const BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(45),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                      ),
                      child: TabBar(
                        controller: tabController,
                        indicatorColor: Colors.transparent,
                        unselectedLabelColor: mainColor,
                        indicator: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelColor: backgroundColor,
                        tabs: const [
                          Tab(
                            child: Center(child: Text('Produk')),
                          ),
                          Tab(
                            child: Center(child: Text('Pesanan')),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          KeepAlivePage(
                            child: ShopItem(tabController),
                          ),
                          KeepAlivePage(
                            child: ProductPesanan(tabController),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
