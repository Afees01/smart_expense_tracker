import 'package:flutter/material.dart';

import 'package:smart_expense_tracker/core/theme/app_colors.dart';
import 'package:smart_expense_tracker/core/theme/app_text_styles.dart';

class SmartAllocationCard extends StatelessWidget {
  final String message;
  final VoidCallback? onReview;

  const SmartAllocationCard({
    super.key,
    required this.message,
    this.onReview,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: AppColors.primary,

        borderRadius:
            BorderRadius.circular(12),

        boxShadow: const [
          BoxShadow(
            color: Color(0x33006C49),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),

      child: Stack(
        children: [
          // ==================================================
          // DECORATION
          // ==================================================

          Positioned(
            right: -20,
            bottom: -20,

            child: Container(
              width: 160,
              height: 160,

              decoration: BoxDecoration(
                color: AppColors
                    .onPrimaryFixedVariant
                    .withOpacity(0.2),

                shape: BoxShape.circle,
              ),
            ),
          ),

          // ==================================================
          // CONTENT
          // ==================================================

          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(
                'Smart Allocation',

                style: AppTextStyles
                    .headlineMd
                    .copyWith(
                  color:
                      AppColors.onPrimary,
                ),
              ),

              const SizedBox(
                height: 8,
              ),

              Text(
                message,

                style: AppTextStyles.bodyMd
                    .copyWith(
                  color: AppColors
                      .onPrimary
                      .withOpacity(0.9),
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              ElevatedButton(
                onPressed: onReview,

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      AppColors.onPrimary,

                  foregroundColor:
                      AppColors.primary,

                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),

                  textStyle:
                      AppTextStyles.labelMd,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8),
                  ),

                  elevation: 0,
                ),

                child: const Text(
                  'Review Suggestion',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}