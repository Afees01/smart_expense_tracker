import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_expense_tracker/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:smart_expense_tracker/features/auth/presentation/bloc/bloc/auth_event.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class WealthFlowAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WealthFlowAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64);

  void _showLogoutDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Logout',
          ),
          content: const Text(
            'Are you sure you want to logout?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text(
                'Cancel',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();

                context.read<AuthBloc>().add(
                      LogoutRequested(),
                    );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Logged out',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Logout',
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 1,
      shadowColor: const Color(0x0D000000),
      surfaceTintColor: Colors.transparent,
      titleSpacing: 20,
      title: Row(
        children: [
          // Profile image
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.secondaryContainer,
            child: ClipOval(
              child: Image.network(
                'https://i.pravatar.cc/150?img=33',
                width: 36,
                height: 36,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return const Icon(
                    Icons.person,
                    color: AppColors.onSecondaryContainer,
                  );
                },
              ),
            ),
          ),

          const SizedBox(
            width: 12,
          ),

          // App name
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
        // Notification
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_outlined,
            color: AppColors.primary,
          ),
          padding: const EdgeInsets.all(8),
        ),

        // Logout
        IconButton(
          onPressed: () {
            _showLogoutDialog(
              context,
            );
          },
          icon: const Icon(
            Icons.logout_outlined,
            color: AppColors.error,
          ),
          tooltip: 'Logout',
          padding: const EdgeInsets.all(8),
        ),

        const SizedBox(
          width: 8,
        ),
      ],
    );
  }
}
