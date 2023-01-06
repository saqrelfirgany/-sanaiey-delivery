
import 'package:flutter/material.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/utils/responsive.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData icon;
  final double size;
  final Color color;

  const CustomIconButton(
      {Key? key,
      this.color: whiteColor,
      this.icon: Icons.add,
      this.onTap,
      this.size: 0.04})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Icon(icon,
            color: color,
            size: isLandscape(context)
                ? 2 * height(context) * size
                : height(context) * size));
  }
}
