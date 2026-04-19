import 'package:flutter/material.dart';
import 'package:hm_demo/pages/mine_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: currentIndex,
          children: const [
            Text('home view'),
            Text('category view'),
            Text('cart view'),
            MineView(),
          ],
        ),
      ),
      bottomNavigationBar: _createBottomNavigationBar(),
    );
  }

  BottomNavigationBar _createBottomNavigationBar() {
    List<Map<String, dynamic>> items = [
      {
        'label': '首页',
        'icon': 'assets/ic_public_home_normal.png',
        'icon_active': 'assets/ic_public_home_active.png',
      },
      {
        'label': '类别',
        'icon': 'assets/ic_public_pro_normal.png',
        'icon_active': 'assets/ic_public_pro_active.png',
      },
      {
        'label': '购物车',
        'icon': 'assets/ic_public_cart_normal.png',
        'icon_active': 'assets/ic_public_cart_active.png',
      },
      {
        'label': '我的',
        'icon': 'assets/ic_public_my_normal.png',
        'icon_active': 'assets/ic_public_my_active.png',
      },
    ];
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: List.generate(
        items.length,
        (int index) => BottomNavigationBarItem(
          icon: Image.asset(items[index]['icon']),
          label: items[index]['label'],
          activeIcon: Image.asset(items[index]['icon_active']),
        ),
      ),
    );
  }
}
