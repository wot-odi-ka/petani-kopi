import 'package:firebase_core/firebase_core.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:petani_kopi/screen/card/cart.dart';
import 'package:petani_kopi/screen/card/search_page.dart';

import 'package:petani_kopi/screen/dashboard/dashboard_page.dart';
import 'package:petani_kopi/screen/login/login_main.dart';
import 'package:petani_kopi/screen/profil/profil_page.dart';
import 'package:petani_kopi/service/locator.dart';
import 'package:petani_kopi/service/route_generator.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    navigatorKey: locator<NavigatorService>().navigatorKey,
    onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
    title: 'Petani Kopi',
    home: const LoginMainPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late PageController _pageController;
  int _selectedPage = 0;

  List<Widget> pages = [
    const DashboardPage(),
    const CardPage(),
    const SearchPage(),
    const ProfileSettingsPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (index) => setState(() {
          _selectedPage = index;
        }),
        controller: _pageController,
        children: [...pages],
      ),
      bottomNavigationBar: FlashyTabBar(
        backgroundColor: const Color(0xFF0d1015),
        selectedIndex: _selectedPage,
        showElevation: false,
        onItemSelected: (index) => _onItemTapped(index),
        items: [
          FlashyTabBarItem(
            activeColor: Colors.brown,
            icon: const Icon(Icons.home_outlined, size: 23),
            title: const Text('Home'),
          ),
          FlashyTabBarItem(
            activeColor: Colors.brown,
            icon: const Icon(Icons.shopping_bag_outlined, size: 23),
            title: const Text('Cart'),
          ),
          FlashyTabBarItem(
            activeColor: Colors.brown,
            icon: const Icon(Icons.search, size: 23),
            title: const Text('Search'),
          ),
          FlashyTabBarItem(
            activeColor: Colors.brown,
            icon: const Icon(
              Icons.person_outline,
              size: 23,
            ),
            title: const Text('Profil'),
          ),
        ],
      ),
    );
  }
}
