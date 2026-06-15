import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_expense_tracker/features/auth/domain/repositories/auth_repository.dart';
import 'package:smart_expense_tracker/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:smart_expense_tracker/features/auth/presentation/bloc/bloc/auth_state.dart';
import 'package:smart_expense_tracker/features/auth/presentation/screens/Loginscreen.dart';
import 'package:smart_expense_tracker/shared/navigation/Routes.dart';
import 'core/theme/app_theme.dart';
import 'shared/app_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const WealthFlowApp());
}

class WealthFlowApp extends StatelessWidget {
  const WealthFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthBloc(
              AuthRepository(),
            ),
          ),
        ],
        child: MaterialApp(
            title: 'WealthFlow',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            onGenerateRoute: AppRouter.generateRoute,
            home: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              if (state is AuthAuthenticated) {
                return const AppShell();
              }

              return const LoginScreen();
            })));
  }
}
