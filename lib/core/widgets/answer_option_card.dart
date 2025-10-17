import 'package:flutter/material.dart';
import 'package:hippoquiz/core/constants/app_colors.dart';
import 'package:hippoquiz/core/constants/app_sizes.dart';
import 'package:hippoquiz/core/constants/app_text_styles.dart';

enum AnswerState {
  normal,
  selected,
  correct,
  incorrect,
}

class AnswerOptionCard extends StatelessWidget {
  final String text;
  final String optionLabel;
  final AnswerState state;
  final VoidCallback? onTap;
  final bool isEnabled;

  const AnswerOptionCard({
    super.key,
    required this.text,
    required this.optionLabel,
    this.state = AnswerState.normal,
    this.onTap,
    this.isEnabled = true,
  });

  Color _getBackgroundColor() {
    switch (state) {
      case AnswerState.selected:
        return AppColors.primary.withValues(alpha: 0.1);
      case AnswerState.correct:
        return AppColors.success.withValues(alpha: 0.1);
      case AnswerState.incorrect:
        return AppColors.error.withValues(alpha: 0.1);
      default:
        return AppColors.surface;
    }
  }

  Color _getBorderColor() {
    switch (state) {
      case AnswerState.selected:
        return AppColors.primary;
      case AnswerState.correct:
        return AppColors.success;
      case AnswerState.incorrect:
        return AppColors.error;
      default:
        return AppColors.border;
    }
  }

  Color _getLabelBackgroundColor() {
    switch (state) {
      case AnswerState.selected:
        return AppColors.primary;
      case AnswerState.correct:
        return AppColors.success;
      case AnswerState.incorrect:
        return AppColors.error;
      default:
        return AppColors.border;
    }
  }

  IconData? _getIcon() {
    switch (state) {
      case AnswerState.correct:
        return Icons.check_circle;
      case AnswerState.incorrect:
        return Icons.cancel;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSizes.paddingMd),
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          border: Border.all(
            color: _getBorderColor(),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: _getLabelBackgroundColor(),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  optionLabel,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: state == AnswerState.normal
                        ? AppColors.textPrimary
                        : Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSizes.spacingMd),
            Expanded(
              child: Text(
                text,
                style: AppTextStyles.answerText,
              ),
            ),
            if (_getIcon() != null) ...[
              const SizedBox(width: AppSizes.spacingSm),
              Icon(
                _getIcon(),
                color: _getBorderColor(),
                size: AppSizes.iconMd,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
