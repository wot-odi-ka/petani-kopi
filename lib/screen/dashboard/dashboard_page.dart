// ignore_for_file: prefer_const_constructors, avoid_print, avoid_unnecessary_containers, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:petani_kopi/animation/common_detail.dart';
import 'package:petani_kopi/drawer/nav_drawer.dart';
import 'package:petani_kopi/helper/page.dart';
import 'package:petani_kopi/service/jump.dart';

import 'dasboard_detail.dart';
import 'dasboard_widgets.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DashboardBody();
  }
}

class DashboardBody extends StatefulWidget {
  const DashboardBody({Key? key}) : super(key: key);

  @override
  _DashboardBodyState createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  final verticalController = ScrollController();
  final horizontalController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF0d1015),
        automaticallyImplyLeading: false,
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.menu_rounded,
        //     size: 25,
        //   ),
        //   onPressed: () {
        //     _key.currentState!.openDrawer();
        //   },
        // ),
        actions: [
          Center(
            child: Stack(
              children: [
                IconButton(
                  color: Colors.white,
                  iconSize: 25,
                  onPressed: () {
                    Jump.replace(Pages.notivication);
                  },
                  icon: Icon(Icons.add_alert_rounded),
                ),
                Visibility(
                  visible: true,
                  child: Positioned(
                    top: 1,
                    right: 5,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: Text(
                        3.toString(),
                        style:
                            const TextStyle(fontSize: 11, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          // SizedBox(
          //   height: 35,
          //   width: 40,
          //   child: CircleAvatar(
          //     backgroundColor: Colors.grey.withOpacity(0.5),
          //     child: IconButton(
          //       alignment: Alignment.center,
          //       icon: Icon(
          //         Icons.person,
          //         color: Colors.white,
          //       ),
          //       onPressed: () {
          //         print('tesst icon button');
          //         Jump.replace(Pages.profilPage);
          //       },
          //     ),
          //   ),
          // ),
          SizedBox(width: 20),
        ],
      ),
      drawer: _buildDrawer(),
      backgroundColor: Color(0xFF0d1015),
      body: Container(
        height: size.height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Find the best',
              style: headerStyle(),
            ),
            Text(
              'coffee for you',
              style: headerStyle(),
            ),
            SizedBox(height: 30),
            const DashboardField(
              hint: 'Find Your Coffee...',
              borderColor: Color(0xFF161922),
              prefixIcon: Icon(
                IconlyLight.search,
                color: Colors.white,
              ),
            ),
            //   Column(
            //   children: [
            //     Padding(padding: EdgeInsets.only(top: 20)),
            //     Text(
            //       'Special for you',
            //       style: ButtomStyle(),
            //     ),
            //   ],
            // ),
            Container(
              child: ListScroll(
                color: Colors.brown,
                label: 'Cappuccino',
              ),
            ),

            Expanded(
              child: Container(
                child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  // padding: EdgeInsets.only(right: 11,left: 4),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                      page: DasboardDetailPage(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   width: 65,
      //   height: 65,
      //   decoration: BoxDecoration(
      //       color: Colors.black.withOpacity(0.4),
      //       borderRadius: BorderRadius.vertical(bottom: Radius.circular(0))),
      //   // boxShadow: [
      //   //   BoxShadow(
      //   //     color: Colors.black.withOpacity(0.4),
      //   //     spreadRadius: 5,
      //   //     blurRadius: 7,
      //   //     offset: Offset(0, 3),
      //   //   )
      //   // ]),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       IconButton(
      //           onPressed: () {
      //             print('test buttom1');
      //           },
      //           icon: Icon(
      //             Icons.home_sharp,
      //             size: 25,
      //             color: Colors.brown[700],
      //           )),
      //       Container(
      //         child: Center(
      //           child: IconButton(
      //               onPressed: () {
      //                 print('test buttom2');
      //                 Jump.replace(Pages.cardPage);
      //               },
      //               icon: Icon(
      //                 Icons.shopping_cart_rounded,
      //                 size: 23,
      //                 color: Colors.grey,
      //               )),
      //         ),
      //       ),
      //       IconButton(
      //           onPressed: () {
      //             Jump.replace(Pages.favoritePage);
      //           },
      //           icon: Icon(
      //             Icons.favorite,
      //             size: 23,
      //             color: Colors.grey,
      //           )),
      //       // ignore: deprecated_member_use
      //       Container(
      //         child: Center(
      //           child: Stack(
      //             children: [
      //               IconButton(
      //                 icon: Icon(Icons.add_alert),
      //                 color: Colors.grey,
      //                 iconSize: 23,
      //                 onPressed: () {
      //                   Jump.replace(Pages.notivication);
      //                 },
      //               ),
      //               Visibility(
      //                 visible: true,
      //                 child: Positioned(
      //                   top: -4,
      //                   right: 4,
      //                   child: Container(
      //                     padding: const EdgeInsets.all(3),
      //                     decoration: const BoxDecoration(
      //                       shape: BoxShape.circle,
      //                       color: Colors.red,
      //                     ),
      //                     child: Text(
      //                       3.toString(),
      //                       style: const TextStyle(
      //                           fontSize: 11, color: Colors.white),
      //                     ),
      //                   ),
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}

TextStyle headerStyle() {
  return const TextStyle(
    fontSize: 30,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
}

TextStyle ButtomStyle() {
  return TextStyle(
    fontSize: 15,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
}

TextStyle cardStyle() {
  return TextStyle(
    fontSize: 10,
    color: Colors.white,
    fontWeight: FontWeight.normal,
  );
}

TextStyle ListStyle() {
  return TextStyle(
    fontSize: 15,
    color: Colors.brown.shade400,
    fontWeight: FontWeight.bold,
  );
}

Widget Listgambar({required bool isHorizontal}) {
  return AspectRatio(
    aspectRatio: 2,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Visibility(
            visible: isHorizontal,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10), bottom: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 5),
                    )
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20), bottom: Radius.circular(20)),
                    child: Image.asset(
                      'assets/images/kopiHitam.png',
                      alignment: Alignment.center,
                      filterQuality: FilterQuality.high,
                      height: 80,
                    ),
                  ),
                  // Padding(padding: EdgeInsets.only(top: 10)),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Kopi Ireng',
                      style: ButtomStyle(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Biji Kopi Asli',
                      style: cardStyle(),
                    ),
                  ),
                  // Padding(padding: EdgeInsets.only(top: 2)),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Rp.4.59',
                      style: ButtomStyle(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget ListgambarButtom() {
  return Container(
    height: 70,
    width: 250,
    padding: EdgeInsets.only(left: 13),
    child: Material(
      color: Colors.black.withOpacity(0.2),
      borderRadius: BorderRadius.vertical(
          top: Radius.circular(20), bottom: Radius.circular(20)),
      child: InkWell(
        onTap: () {
          print('asd');
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20), bottom: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 3),
                )
              ]),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30), bottom: Radius.circular(30)),
                child: Image.asset(
                  'assets/images/kopiHitam.png',
                  filterQuality: FilterQuality.high,
                  height: 110,
                ),
              ),
              // Padding(padding: EdgeInsets.only(top: 10)),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Cappucinno',
                  style: ButtomStyle(),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Whit Oat Milk',
                  style: cardStyle(),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 2)),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '\$4.59',
                  style: ButtomStyle(),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget ListScroll({MaterialColor? color, String? label}) {
  return Container(
    height: 60,
    color: Colors.transparent,
    child: ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) => Center(
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            label! + index.toString(),
            style: ListStyle(),
          ),
        ),
      ),
    ),
  );
}

_buildDrawer() {
  return ClipPath(
    child: Drawer(
      child: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 40),
        decoration: BoxDecoration(
            color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
        width: 300,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.power_settings_new,
                      color: active,
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  height: 90,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: [Colors.pink, Colors.deepPurple])),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/kopiHitam.png'),
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'erika costell',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                Text(
                  '@erika07',
                  style: TextStyle(color: active, fontSize: 16.0),
                ),
                SizedBox(height: 30.0),
                _buildRow(Icons.home, 'Home'),
                _buildDivider(),
                _buildRow(Icons.person_pin, 'Your profile'),
                _buildDivider(),
                _buildRow(Icons.settings, 'Settings'),
                _buildDivider(),
                _buildRow(Icons.email, 'Contact us'),
                _buildDivider(),
                _buildRow(Icons.info_outline, 'Help'),
                _buildDivider(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Divider _buildDivider() {
  return Divider(
    color: active,
  );
}

Widget _buildRow(IconData icon, String title) {
  final tStyle = TextStyle(color: active, fontSize: 16.0);
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(children: [
      Icon(
        icon,
        color: active,
      ),
      SizedBox(width: 10.0),
      Text(
        title,
        style: tStyle,
      ),
    ]),
  );
}

Widget iconeBtn() {
  return Container(
    child: Icon(Icons.shop),
  );
}
