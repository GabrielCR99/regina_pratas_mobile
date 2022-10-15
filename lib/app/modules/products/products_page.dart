import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core/auth/auth_store.dart';
import 'products_controller.dart';
import 'widgets/category_tile.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final _controller = Modular.get<ProductsController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _controller.getProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Observer(
          builder: (_) => Text(
            'Olá, ${Modular.get<AuthStore>().currentUser?.displayName ?? 'Não informado'}!',
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 80,
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, index) => Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CategoryTile(
                  backgroundColor: Colors.white,
                  label: 'Categoria $index',
                  selected: index.isEven,
                  onSelected: (value) {},
                  selectedColor: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
