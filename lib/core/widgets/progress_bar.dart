import 'package:flutter/material.dart';
import 'package:hippoquiz/core/constants/app_colors.dart';
import 'package:hippoquiz/core/constants/app_sizes.dart';

class CustomProgressBar extends StatelessWidget {
  final double progress;
  final Color? color;
  final Color? backgroundColor;
  final double height;
  final bool showPercentage;

  const CustomProgressBar({
    super.key,
    required this.progress,
    this.color,
    this.backgroundColor,
    this.height = AppSizes.progressBarHeight,
    this.showPercentage = false,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (progress * 100).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showPercentage)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSizes.spacingXs),
            child: Text(
              '$percentage%',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color ?? AppColors.primary,
              ),
            ),
          ),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.progressBarRadius),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            minHeight: height,
            backgroundColor: backgroundColor ?? AppColors.border,
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class CircularProgress extends StatelessWidget {
  final double progress;
  final Color? color;
  final Color? backgroundColor;
  final double size;
  final double strokeWidth;
  final Widget? child;

  const CircularProgress({
    super.key,
    required this.progress,
    this.color,
    this.backgroundColor,
    this.size = 60,
    this.strokeWidth = 6,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            strokeWidth: strokeWidth,
            backgroundColor: backgroundColor ?? AppColors.border,
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? AppColors.primary,
            ),
          ),
          if (child != null)
            SizedBox(
              width: size - (strokeWidth * 2),
              height: size - (strokeWidth * 2),
              child: Center(
                child: child!,
              ),
            ),
        ],
      ),
    );
  }
}
