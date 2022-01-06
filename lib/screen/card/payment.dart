import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petani_kopi/bloc/permission_bloc/permission_bloc.dart';
import 'package:petani_kopi/bloc/permission_bloc/permission_event.dart';
import 'package:petani_kopi/bloc/profil_block/profil_block.dart';
import 'package:petani_kopi/bloc/profil_block/profil_event.dart';
import 'package:petani_kopi/common/common_button.dart';
import 'package:petani_kopi/common/common_upload_choice.dart';
import 'package:petani_kopi/common/custom_gallery/gallery_utils.dart';
import 'package:petani_kopi/helper/page.dart';
import 'package:petani_kopi/model/item.dart';
import 'package:petani_kopi/service/jump.dart';
import 'package:petani_kopi/theme/colors.dart';

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
  File? image;
  late Timer? timer;

  bloc(ProfilEvent event) {
    BlocProvider.of<ProfilBlock>(context).add(event);
  }

  permissionBloc(PermissionEvent event) {
    BlocProvider.of<PermissionBloc>(context).add(event);
  }

  late List<dynamic> cartItems = [];
  List<int> cartItemCount = [1, 1, 1, 1, 1, 1];
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
        bottomOpacity: 34,
        backgroundColor: const Color(0xFF0d1015),
        elevation: 10,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Jump.to(Pages.cardPage);
          },
        ),
        title: const Text(
          'Payment',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: MediaQuery.of(context).size.height * 0.75,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: cartItems.isNotEmpty
                      ? ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (ctx, index) {
                            return cartItem(cartItems[index], index);
                          })
                      : Container(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ButtonConfirm(
                text: "Selesai Pembayaran",
                fontSize: 15,
                width: 310,
                onTap: () => Jump.to(Pages.pymentSuccses),
              ),
            ),
          ]),
    );
  }

  cartItem(Item itemProduct, int index) {
    return GestureDetector(
      onTap: () {},
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
                margin: const EdgeInsets.only(right: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    itemProduct.imageURL,
                    fit: BoxFit.cover,
                    height: 60,
                    width: 60,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        itemProduct.brand,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        itemProduct.name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Total Pembayaran RP.${itemProduct.price}',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ]),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ButtonConfirm(
                    text: "upload",
                    fontSize: 10,
                    width: 110,
                    onTap: () => showUploadChoice(),
                  ),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }

  showUploadChoice() {
    return showModalBottomSheet(
      context: context,
      backgroundColor: backgroundColor,
      builder: (context) => SelectMediaBody(
        camera: () {
          Navigator.of(context).pop();
          permissionBloc(GetCameraPermission());
        },
        gallery: () {
          Navigator.of(context).pop();
          permissionBloc(GetStoragePermission());
        },
      ),
    );
  }

  galery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      File? compressed = await compressFile(File(photo.path));
      if (compressed != null) {
        setState(() {
          image = compressed;
        });
      }
    }
  }

  onCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      File? compressed = await compressFile(File(photo.path));
      if (compressed != null) {
        setState(() {
          image = compressed;
        });
      }
    }
  }
}
