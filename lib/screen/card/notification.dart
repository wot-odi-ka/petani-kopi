import 'package:flutter/material.dart';
import 'package:petani_kopi/helper/page.dart';
import 'package:petani_kopi/service/jump.dart';
import 'package:shimmer/shimmer.dart';

class NotivicationPage extends StatefulWidget {
  const NotivicationPage({Key? key}) : super(key: key);

  @override
  _NotivicationPageState createState() => _NotivicationPageState();
}

class _NotivicationPageState extends State<NotivicationPage> {
  var listNotiv = ['pesanan anda menungu konfirmasi', 'Kopi Hitam', '12:12'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Jump.to(Pages.homePage);
          },
        ),
        elevation: 0,
        title: const Text(
          "Notivication",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: listNotiv.isEmpty
              ? ListView.builder(
                  itemCount: 8,
                  itemBuilder: (BuildContext ctx, index) {
                    int timer = 1000;
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.white,
                      period: Duration(milliseconds: timer),
                      child: box(),
                    );
                  })
              : ListView.builder(
                  itemCount: 8,
                  itemBuilder: (BuildContext ctx, index) {
                    return notivItem();
                  })),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  Widget notivItem() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  alignment: Alignment.topLeft,
                  child:
                      Text(listNotiv[0], style: const TextStyle(fontSize: 12)),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child:
                      Text(listNotiv[1], style: const TextStyle(fontSize: 12)),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    listNotiv[2],
                    style: const TextStyle(fontSize: 10),
                  ),
                )
              ],
            ),
          )
        ],
      ),
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
