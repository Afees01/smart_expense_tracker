import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class WealthFlowAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WealthFlowAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 1,
      shadowColor: const Color(0x0D000000),
      surfaceTintColor: Colors.transparent,
      titleSpacing: 20,
      title: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.secondaryContainer,
            child: ClipOval(
              child: Image.network(
                'https://i.pravatar.cc/150?img=33',
                width: 36,
                height: 36,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.person,
                  color: AppColors.onSecondaryContainer,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'WealthFlow',
            style: AppTextStyles.headlineMd.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_outlined,
            color: AppColors.primary,
          ),
          padding: const EdgeInsets.all(8),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
