import 'dart:async';

import 'package:flutter/material.dart';
import 'package:petani_kopi/helper/page.dart';
import 'package:petani_kopi/service/jump.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PaymentBoddy();
  }
}

class PaymentBoddy extends StatefulWidget {
  const PaymentBoddy({Key? key}) : super(key: key);

  @override
  _PaymentBoddyState createState() => _PaymentBoddyState();
}

class _PaymentBoddyState extends State<PaymentBoddy> {
  int activeCard = 0;
  bool _isLoading = false;
  late Timer? timer;

  pay() {
    setState(() {
      _isLoading = true;
    });
    const oneSec = Duration(seconds: 2);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          _isLoading = false;
          timer.cancel();
          Jump.replace(Pages.pymentSuccses);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF0d1015),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Jump.replace(Pages.cardPage);
            },
          ),
          title: const Text(
            'Payment',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                activeCard == 0
                    ? AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: activeCard == 0 ? 1 : 0,
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.orange,
                                  Colors.yellow.shade800,
                                  Colors.yellow.shade900,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Credit Card",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "**** **** **** 7890",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 30),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "master card",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Image.asset(
                                            'assets/images/mastercard-logo.png',
                                            height: 50),
                                      ],
                                    )
                                  ],
                                )
                              ]),
                        ),
                      )
                    : AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: activeCard == 1 ? 1 : 0,
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          padding: const EdgeInsets.all(30.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              // color: Colors.grey.shade200
                              gradient: LinearGradient(
                                colors: [
                                  Colors.grey.shade200,
                                  Colors.grey.shade100,
                                  Colors.grey.shade200,
                                  Colors.grey.shade300,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                        'assets/images/mastercard-logo.png',
                                        height: 50),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const Text(
                                          "Petani Kopi",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                        Image.asset(
                                            'assets/images/mastercard-logo.png',
                                            height: 50),
                                      ],
                                    )
                                  ],
                                )
                              ]),
                        ),
                      ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Payment Method",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        activeCard = 0;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: activeCard == 0
                            ? Border.all(color: Colors.grey.shade300, width: 1)
                            : Border.all(
                                color: Colors.grey.shade300.withOpacity(0),
                                width: 1),
                      ),
                      child: Image.asset('assets/images/mastercard-logo.png',
                          height: 50),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        activeCard = 1;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: activeCard == 1
                            ? Border.all(color: Colors.grey.shade300, width: 1)
                            : Border.all(
                                color: Colors.grey.shade300.withOpacity(0),
                                width: 1),
                      ),
                      child: Image.asset('assets/images/mastercard-logo.png',
                          height: 50),
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Offers",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                          onPressed: () {}, child: const Text("Add a code"))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Address",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Row(
                            children: const [
                              Text("E-75, Diamond Dis..."),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 20,
                              )
                            ],
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Total Payment",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Text("\$240.00",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))
                  ],
                ),
                const SizedBox(height: 30),
                MaterialButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          pay();
                        },
                  height: 50,
                  elevation: 0,
                  splashColor: Colors.yellow[700],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: const Color(0xFF0d1015),
                  child: Center(
                    child: _isLoading
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
                            "Pay",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ));
  }
}
