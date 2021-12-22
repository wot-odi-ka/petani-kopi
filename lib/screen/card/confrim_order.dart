import 'package:flutter/material.dart';

class ConfirmOrderPage extends StatelessWidget {
  const ConfirmOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ConfirmOrderPageBody();
  }
}

class ConfirmOrderPageBody extends StatefulWidget {
  const ConfirmOrderPageBody({Key? key}) : super(key: key);

  @override
  _ConfirmOrderPageBody createState() => _ConfirmOrderPageBody();
}

class _ConfirmOrderPageBody extends State<ConfirmOrderPageBody> {
  final String address = 'Depok, jawa barat, Indonesia';
  final String phone = '081382698461';
  final double total = 500;
  final double delivery = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Confirm Order'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
          left: 20.0, right: 20.0, top: 40.0, bottom: 10.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text('Subtotal'),
              Text('Rp. $total'),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text('Delivery fee'),
              Text('Rp. $delivery'),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Total',
              ),
              Text(
                'Rp. ${total + delivery}',
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              child: Text(
                'Delivery Address'.toUpperCase(),
                style: const TextStyle(color: Colors.black),
              )),
          Column(
            children: <Widget>[
              RadioListTile(
                selected: true,
                value: address,
                groupValue: address,
                title: Text(address),
                onChanged: (dynamic value) {},
              ),
              RadioListTile(
                selected: false,
                value: 'New Address',
                groupValue: address,
                title: const Text('Choose new delivery address'),
                onChanged: (dynamic value) {},
              ),
              Container(
                  color: Colors.grey.shade200,
                  padding: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: Text(
                    'Contact Number'.toUpperCase(),
                    style: const TextStyle(color: Colors.black),
                  )),
              RadioListTile(
                selected: true,
                value: phone,
                groupValue: phone,
                title: Text(phone),
                onChanged: (dynamic value) {},
              ),
              RadioListTile(
                selected: false,
                value: 'New Phone',
                groupValue: phone,
                title: const Text('Choose new contact number'),
                onChanged: (dynamic value) {},
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              child: Text(
                'Payment Option'.toUpperCase(),
                style: const TextStyle(color: Colors.black),
              )),
          RadioListTile(
            groupValue: true,
            value: true,
            title: const Text('Cash on Delivery'),
            onChanged: (dynamic value) {},
          ),
          SizedBox(
            width: double.infinity,
            // ignore: deprecated_member_use
            child: RaisedButton(
              color: Colors.brown[700],
              onPressed: () => {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: const SizedBox(
                height: 50,
                width: 90,
                child: Center(
                  child: Text(
                    'Confirm Order',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
