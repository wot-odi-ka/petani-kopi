// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

final Color primary = Color(0xff291747);
final Color active = Color(0xff6C48AB);

Drawer navigationdrawer() {
  return Drawer(
    child: _buildDrawer(),
  );
}

ClipPath _buildDrawer() {
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
  final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
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

@override
Widget build(BuildContext context) {
  throw UnimplementedError();
}

class OvalRightBorderClipper {}
