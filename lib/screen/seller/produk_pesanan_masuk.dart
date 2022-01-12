import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:petani_kopi/animation/common_detail.dart';
import 'package:petani_kopi/common/common_alert_dialog.dart';
import 'package:petani_kopi/common/common_empty_shop.dart';
import 'package:petani_kopi/common/common_loading.dart';
import 'package:petani_kopi/helper/app_scaler.dart';
import 'package:petani_kopi/model/orderitemlist.dart';
import 'package:petani_kopi/model/product.dart';
import 'package:petani_kopi/screen/seller/my_order_items.dart';

class PesananMasukPage extends StatefulWidget {
  const PesananMasukPage(TabController tabController, {Key? key})
      : super(key: key);

  @override
  State<PesananMasukPage> createState() => _PesananMasukPageState();
}

class _PesananMasukPageState extends State<PesananMasukPage> {
  @override
  Widget build(BuildContext context) {
    return const PesananMasukBoddy();
  }
}

class PesananMasukBoddy extends StatefulWidget {
  const PesananMasukBoddy({Key? key}) : super(key: key);

  @override
  _PesananMasukBoddyState createState() => _PesananMasukBoddyState();
}

class _PesananMasukBoddyState extends State<PesananMasukBoddy> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  final verticalController = ScrollController();
  final horizontalController = ScrollController();
  ScrollController scrollController = ScrollController();
  Stream<QuerySnapshot>? shopStream;

  Widget buildTile(
    DocumentSnapshot query, {
    required int deletedIndex,
  }) {
    var map = query.data() as Map<String, dynamic>;
    return MyOrderItem(
      model: Product.fromSearch(map),
      onDelete: () {
        context.showAlertDialog(
          onTapYes: () {
            Navigator.of(context).pop();
            // bloc(DeleteProductById(Product.fromSearch(map), deletedIndex));
          },
          description: 'Deleted items cannot be restored',
          title: 'Are you sure?',
          yesText: 'Yes',
          cancelText: 'No',
        );
      },
    );
  }

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
            child: SizedBox(
              width: context.width(),
              child: StreamBuilder<QuerySnapshot>(
                stream: shopStream,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.length > 0) {
                      return StaggeredGridView.countBuilder(
                        crossAxisCount: 4,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        staggeredTileBuilder: (index) =>
                            const StaggeredTile.fit(4),
                        padding: const EdgeInsets.only(
                          left: 18,
                          top: 12,
                          right: 18,
                        ),
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          var query = snapshot.data.docs[index];
                          return buildTile(
                            query as DocumentSnapshot,
                            deletedIndex: index,
                          );
                        },
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: EmptyProducts(
                              onTap: () {},
                            ),
                          ),
                        ],
                      );
                    }
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Flexible(
                          child: CommonLoading(),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
