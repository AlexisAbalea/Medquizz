import 'package:flutter/material.dart';
import 'package:hippoquiz/core/constants/app_colors.dart';
import 'package:hippoquiz/core/constants/app_sizes.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final VoidCallback? onTap;
  final double? elevation;
  final double borderRadius;
  final Border? border;

  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.onTap,
    this.elevation,
    this.borderRadius = AppSizes.radiusLg,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final card = Card(
      elevation: elevation ?? AppSizes.cardElevation,
      color: color ?? AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: border?.top ?? BorderSide.none,
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(AppSizes.paddingMd),
        child: child,
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: card,
      );
    }

    return card;
  }
}
