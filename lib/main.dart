import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_expense_tracker/core/network/network_client.dart';
import 'package:smart_expense_tracker/core/network/securetoken.dart';
import 'package:smart_expense_tracker/features/auth/data/datasources/AuthRemoteDataSource.dart';
import 'package:smart_expense_tracker/features/auth/presentation/repositories/auth_repository.dart';
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
  final networkClient = NetworkClient();
  final token = Securetoken();

  runApp(WealthFlowApp(
    client: networkClient,
    token: token,
  ));
}

class WealthFlowApp extends StatelessWidget {
  final NetworkClient client;
  final Securetoken token;

  const WealthFlowApp({super.key, required this.client, required this.token});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthBloc(
              AuthRepository(
                  dataSource: AuthRemoteDataSource(
                client,token
              )),
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
