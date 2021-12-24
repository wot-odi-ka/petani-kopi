import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:petani_kopi/helper/page.dart';
import 'package:petani_kopi/model/item.dart';
import 'package:petani_kopi/service/jump.dart';

class CardPage extends StatelessWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CartdBody();
  }
}

class CartdBody extends StatefulWidget {
  const CartdBody({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartdBody> with TickerProviderStateMixin {
  late List<dynamic> cartItems = [];
  List<int> cartItemCount = [1, 1, 1, 1];
  int totalPrice = 0;

  Future<void> fetchItems() async {
    final String response = await rootBundle.loadString('assets/products.json');
    final data = await json.decode(response);

    cartItems = data['products'].map((data) => Item.fromJson(data)).toList();

    sumTotal();
  }

  sumTotal() {
    for (var item in cartItems) {
      totalPrice = item.price + totalPrice;
    }
  }

  @override
  void initState() {
    super.initState();

    fetchItems().whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF0d1015),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Jump.replace(Pages.homePage);
            },
          ),
          title: const Text('My Cart', style: TextStyle(color: Colors.white)),
          actions: [
            SizedBox(
                width: 70.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Center(
                      child: Stack(
                        children: [
                          IconButton(
                            color: Colors.white,
                            iconSize: 23,
                            onPressed: () {},
                            icon: const Icon(Icons.shopping_bag_rounded),
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
                                  style: const TextStyle(
                                      fontSize: 11, color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: MediaQuery.of(context).size.height * 0.63,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: cartItems.isNotEmpty
                    ? AnimatedList(
                        scrollDirection: Axis.vertical,
                        initialItemCount: cartItems.length,
                        itemBuilder: (context, index, animation) {
                          return Slidable(
                            actionPane: const SlidableDrawerActionPane(),
                            secondaryActions: [
                              MaterialButton(
                                color: Colors.red.withOpacity(0.15),
                                elevation: 0,
                                height: 40,
                                minWidth: 40,
                                shape: const CircleBorder(),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 30,
                                ),
                                onPressed: () {
                                  setState(() {
                                    totalPrice = totalPrice -
                                        (int.parse(cartItems[index]
                                                .price
                                                .toString()) *
                                            cartItemCount[index]);

                                    AnimatedList.of(context).removeItem(index,
                                        (context, animation) {
                                      return cartItem(
                                          cartItems[index], index, animation);
                                    });

                                    cartItems.removeAt(index);
                                    cartItemCount.removeAt(index);
                                  });
                                },
                              ),
                            ],
                            child: cartItem(cartItems[index], index, animation),
                          );
                        })
                    : Container(),
              ),
            ),
          ),
          // const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                // Text('Shipping', style: TextStyle(fontSize: 20)),
                // SizedBox(height: 60),
                // Text('Rp.1.000',
                //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Total', style: TextStyle(fontSize: 20)),
                Text('Rp.$totalPrice',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold))
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: MaterialButton(
              onPressed: () {
                Jump.replace(Pages.confrimOrder);
              },
              height: 50,
              elevation: 0,
              splashColor: const Color(0xFF0d1015),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: const Color(0xFF0d1015),
              child: const Center(
                child: Text(
                  "Checkout",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          )
        ]));
  }

  cartItem(Item itemProduct, int index, animation) {
    return GestureDetector(
      onTap: () {},
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
            .animate(animation),
        child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.blueGrey[50],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(0, 2),
                blurRadius: 6,
              ),
            ],
          ),
          child: Column(
            children: [
              Row(children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 65),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.asset(
                      'assets/images/kopiHitam.png',
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Arabika',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Kopi ireng',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Rp.${100000}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ]),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      minWidth: 10,
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        setState(() {
                          if (cartItemCount[index] > 0) {
                            cartItemCount[index]--;
                            totalPrice = totalPrice - itemProduct.price;
                          }
                        });
                      },
                      shape: const CircleBorder(),
                      child: const Icon(
                        Icons.remove_circle_outline,
                        color: Colors.brown,
                        size: 30,
                      ),
                    ),
                    Center(
                      child: Text(
                        cartItemCount[index].toString(),
                        style: TextStyle(
                            fontSize: 20, color: Colors.grey.shade800),
                      ),
                    ),
                    MaterialButton(
                      padding: const EdgeInsets.all(0),
                      minWidth: 10,
                      splashColor: Colors.brown,
                      onPressed: () {
                        setState(() {
                          cartItemCount[index]++;
                          totalPrice = totalPrice + itemProduct.price;
                        });
                      },
                      shape: const CircleBorder(),
                      child: const Icon(
                        Icons.add_circle,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
