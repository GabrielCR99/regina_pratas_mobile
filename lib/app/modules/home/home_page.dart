import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/auth/auth_store.dart';
import 'widgets/category_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Selector<AuthStore, String>(
          builder: (_, value, __) => Text('Olá, $value!'),
          selector: (_, store) => store.currentUser?.displayName ?? '',
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Pesquise aqui...',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                isDense: true,
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search, size: 21),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(60)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20),
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => CategoryTile(
                category: 'Category $index',
                selected: true,
                onTap: () {},
              ),
              separatorBuilder: (_, index) => const SizedBox(width: 10),
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
