import 'package:flutter/material.dart';
import 'package:petani_kopi/common/favorite_header.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FavoritePageBody();
  }
}

class FavoritePageBody extends StatefulWidget {
  const FavoritePageBody({Key? key}) : super(key: key);
  @override
  _FavoritePageBody createState() => _FavoritePageBody();
}

class _FavoritePageBody extends State<FavoritePageBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 50,
            child: Text(
              'Your Wistlist',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 40,
              child: ListView(
                padding: const EdgeInsets.all(10.0),
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ),
                  FavoriteHeader(
                    image: Image.asset('').toString(),
                    subtitle: '',
                    title: '',
                  ),
                  FavoriteHeader(
                    image: Image.asset('').toString(),
                    subtitle: '',
                    title: '',
                  ),
                  FavoriteHeader(
                    image: Image.asset('').toString(),
                    subtitle: '',
                    title: '',
                  ),
                  FavoriteHeader(
                    image: Image.asset('').toString(),
                    subtitle: '',
                    title: '',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          _buildTotals()
        ],
      ),
    );
  }

  Widget _buildTotals() {
    return Container(
        padding: const EdgeInsets.only(left: 50.0, right: 50.0),
        // ignore: deprecated_member_use
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.brown[700],
          onPressed: () {},
          child: SizedBox(
            height: 50,
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const <Widget>[
                Text('Add to Wishlist', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ));
  }
}
