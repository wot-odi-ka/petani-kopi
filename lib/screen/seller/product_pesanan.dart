import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductPesanan extends StatelessWidget {
  const ProductPesanan(TabController tabController, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ProductPesananBoddy();
  }
}

class ProductPesananBoddy extends StatefulWidget {
  const ProductPesananBoddy({Key? key}) : super(key: key);

  @override
  _ProductPesananBoddyState createState() => _ProductPesananBoddyState();
}

class _ProductPesananBoddyState extends State<ProductPesananBoddy> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
          itemCount: 8,
          itemBuilder: (BuildContext ctx, index) {
            int timer = 1000;
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.white,
              period: Duration(milliseconds: timer),
              child: box(),
            );
          }),
    );
  }

  Widget box() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 150,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
