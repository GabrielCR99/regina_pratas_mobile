import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final String label;
  final Color selectedColor;
  final Color backgroundColor;
  final bool selected;
  final ValueChanged<String> onSelected;

  const CategoryTile({
    required this.label,
    required this.selectedColor,
    required this.backgroundColor,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: selected ? selectedColor : backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          onTap: () => onSelected(label),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              border:
                  selected ? null : const Border.fromBorderSide(BorderSide()),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
