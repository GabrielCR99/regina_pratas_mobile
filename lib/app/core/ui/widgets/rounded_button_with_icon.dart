import 'package:flutter/material.dart';

import '../extensions/screen_size_extension.dart';

class RoundedButtonWithIcon extends StatelessWidget {
  final GestureTapCallback onTap;
  final double width;
  final Color color;
  final IconData icon;
  final String label;

  const RoundedButtonWithIcon({
    required this.onTap,
    required this.width,
    required this.color,
    required this.icon,
    required this.label,
    super.key,
  });

  static const _borderRadius = BorderRadius.all(Radius.circular(20));

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: _borderRadius,
      onTap: onTap,
      child: Container(
        width: width,
        height: 35.h,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: _borderRadius,
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20.w),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: VerticalDivider(color: Colors.white, thickness: 2),
            ),
            const Spacer(),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
