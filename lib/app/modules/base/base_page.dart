import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cart/cart_page.dart';
import '../home/home_page.dart';
import '../orders/orders_page.dart';
import '../profile/profile_page.dart';
import 'base_controller.dart';

class BasePage extends StatelessWidget {
  const BasePage({super.key});

  static final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final controller = context.read<BaseController>();

    return Scaffold(
      bottomNavigationBar: Selector<BaseController, int>(
        selector: (_, controller) => controller.currentIndex,
        builder: (_, value, __) => BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Início',
              activeIcon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Carrinho',
              activeIcon: Icon(Icons.shopping_cart),
            ),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Pedidos'),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          currentIndex: value,
          onTap: (index) => _changeIndex(controller, index),
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: const [
          HomePage(),
          CartPage(),
          OrdersPage(),
          ProfilePage(),
        ],
      ),
    );
  }

  void _changeIndex(BaseController controller, int index) {
    controller.currentIndex = index;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }
}
