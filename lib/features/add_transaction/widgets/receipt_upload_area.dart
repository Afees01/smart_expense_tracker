import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ReceiptUploadArea extends StatelessWidget {
  final VoidCallback? onTap;

  const ReceiptUploadArea({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Attach Receipt',
          style: AppTextStyles.labelMd.copyWith(color: AppColors.onSurfaceVariant),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.outlineVariant,
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.add_a_photo_outlined,
                  size: 40,
                  color: AppColors.outline,
                ),
                const SizedBox(height: 8),
                Text(
                  'Click to upload photo',
                  style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                ),
                const SizedBox(height: 4),
                Text(
                  'PNG, JPG up to 10MB',
                  style: AppTextStyles.labelMd.copyWith(color: AppColors.outlineVariant),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
