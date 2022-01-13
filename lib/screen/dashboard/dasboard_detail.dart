import 'package:flutter/material.dart';
import 'package:petani_kopi/helper/page.dart';
import 'package:petani_kopi/service/jump.dart';

import 'dashboard_page.dart';

class DasboardDetailPage extends StatelessWidget {
  const DasboardDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DashboardDetailBody();
  }
}

class DashboardDetailBody extends StatefulWidget {
  const DashboardDetailBody({Key? key}) : super(key: key);

  @override
  _DashboardDetailBodyState createState() => _DashboardDetailBodyState();
}

class _DashboardDetailBodyState extends State<DashboardDetailBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF0d1015),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Jump.to(Pages.homePage);
          },
        ),
        title: const Text(
          'Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: const Color(0xFF0d1015),
      body: _buildPageContent(context),
    );
  }

  Widget _buildPageContent(context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: <Widget>[
              _buildItemCard(context),
              Container(
                  padding: const EdgeInsets.all(30.0),
                  child: const Text(
                    'Kopi Robusta merupakan keturunan beberapa spesies kopi, terutama Coffea canephora. Jenis kopi ini tumbuh baik di ketinggian 400-700 m dpl, temperatur 21-24° C dengan bulan kering 3-4 bulan secara berturut-turut dan 3-4 kali hujan kiriman. Kualitas buah lebih rendah dari Arabika dan Liberika.',
                    // style: buttomStyle(),
                  )),
              Container(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
                  child: Row(
                    children: const [
                      Text(
                        'Arabika',
                        // style: buttomStyle(),
                      ),
                      SizedBox(
                        width: 270,
                      ),
                    ],
                  )),
              //   GroceryListItemTwo(title: 'Broccoli', image: brocoli, subtitle: '1 kg'),
              //   GroceryListItemTwo(title: 'Broccoli', image: cabbage, subtitle: '1 kg'),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: 20, bottom: 10),
                alignment: Alignment.topRight,
                color: Colors.transparent,
                // ignore: deprecated_member_use
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      //SizedBox(width: 20),
                      Column(
                        children: [
                          Text(
                            'Price',
                            style: cardStyle(),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '\$4.50',
                            // style: buttomStyle(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 70,
                      ),
                      // ignore: deprecated_member_use
                      RaisedButton(
                        color: Colors.brown[800],
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: const SizedBox(
                          height: 45,
                          width: 200,
                          child: Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              'Add to Cart',
                              textAlign: TextAlign.center,
                              // style: buttomStyle(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _buildItemCard(context) {
    return Stack(
      children: <Widget>[
        Card(
          color: const Color(0xFF0d1015),
          margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: SizedBox(
            child: Column(
              children: <Widget>[
                Image.asset('assets/images/kopiHitam.png'),
                // IconButton(
                //   onPressed: () {},
                //   icon: Icon(
                //     Icons.favorite_border,
                //     color: Colors.white,
                //   ),
                // ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Local Coffee',
                  style: cardStyle(),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text('1 kg', style: cardStyle())
              ],
            ),
          ),
        ),
      ],
    );
  }
}
