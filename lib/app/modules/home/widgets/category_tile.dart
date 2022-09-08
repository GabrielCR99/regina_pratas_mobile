import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final String category;
  final bool selected;
  final VoidCallback onTap;

  const CategoryTile({
    required this.category,
    required this.selected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Text(
            category,
            style: TextStyle(
              fontSize: selected ? 16 : 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
