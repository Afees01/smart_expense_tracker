import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String _metropolis = 'Metropolis';
  static const String _hankenGrotesk = 'HankenGrotesk';

  static const TextStyle displayLg = TextStyle(
    fontFamily: _metropolis,
    fontSize: 30,
    height: 38 / 30,
    letterSpacing: -0.02 * 30,
    fontWeight: FontWeight.w700,
    color: AppColors.onSurface,
  );

  static const TextStyle headlineLg = TextStyle(
    fontFamily: _metropolis,
    fontSize: 24,
    height: 32 / 24,
    letterSpacing: -0.01 * 24,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );

  static const TextStyle headlineMd = TextStyle(
    fontFamily: _metropolis,
    fontSize: 20,
    height: 28 / 20,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );

  static const TextStyle numericData = TextStyle(
    fontFamily: _metropolis,
    fontSize: 18,
    height: 24 / 18,
    letterSpacing: 0,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );

  static const TextStyle bodyLg = TextStyle(
    fontFamily: _hankenGrotesk,
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
  );

  static const TextStyle bodyMd = TextStyle(
    fontFamily: _hankenGrotesk,
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
  );

  static const TextStyle labelMd = TextStyle(
    fontFamily: _hankenGrotesk,
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0.05 * 12,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );
}
