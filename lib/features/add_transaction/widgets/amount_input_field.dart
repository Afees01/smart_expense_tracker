import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class AmountInputField extends StatefulWidget {
  final TextEditingController controller;

  const AmountInputField({super.key, required this.controller});

  @override
  State<AmountInputField> createState() => _AmountInputFieldState();
}

class _AmountInputFieldState extends State<AmountInputField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'AMOUNT',
          style: AppTextStyles.labelMd.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        Focus(
          onFocusChange: (f) => setState(() => _isFocused = f),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: _isFocused ? AppColors.primaryContainer : AppColors.outlineVariant,
                  width: 2,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '\$',
                  style: AppTextStyles.displayLg.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 28,
                  ),
                ),
                Flexible(
                  child: TextField(
                    controller: widget.controller,
                    textAlign: TextAlign.center,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    style: AppTextStyles.displayLg.copyWith(fontSize: 36),
                    decoration: InputDecoration(
                      hintText: '0.00',
                      hintStyle: AppTextStyles.displayLg.copyWith(
                        fontSize: 36,
                        color: AppColors.outlineVariant,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
