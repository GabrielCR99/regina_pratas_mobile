import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _selectedIndex = ValueNotifier(0);

  final tabs = const ['products', 'cart', 'orders', 'profile'];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: _selectedIndex,
          builder: (_, value, ___) => BottomNavigationBar(
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
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Pedidos',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Perfil',
              ),
            ],
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            currentIndex: value,
            // ignore: prefer-extracting-callbacks
            onTap: (value) {
              _selectedIndex.value = value;
              Modular.to.navigate('/home/${tabs[value]}/');
            },
          ),
        ),
        body: const RouterOutlet(),
      ),
    );
  }
}
