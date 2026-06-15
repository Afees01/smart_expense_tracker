import 'package:flutter/material.dart';
import 'package:smart_expense_tracker/features/auth/presentation/screens/CreateUserScreen.dart';
import 'package:smart_expense_tracker/features/auth/presentation/screens/Loginscreen.dart';
import 'package:smart_expense_tracker/shared/navigation/AppRoutes.dart';

import '../../shared/app_shell.dart';


class AppRouter {
  static Route<dynamic> generateRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case AppRoutes.signup:
        return MaterialPageRoute(
          builder: (_) =>  CreateUserScreen(),
        );

      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const AppShell(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
              ),
            ),
          ),
        );
    }
  }
}