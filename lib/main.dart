import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:otlob_admin/injection_container.dart' as di;
import 'package:otlob_admin/features/auth/presentation/login_screen.dart';
import 'package:otlob_admin/features/auth/presentation/splash_screen.dart';
import 'package:otlob_admin/features/dashboard/presentation/dashboard_screen.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:otlob_admin/generated/l10n/app_localizations.dart';
import 'package:otlob_admin/core/localization/language_cubit.dart';

import 'package:otlob_admin/core/theme/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<LanguageCubit>(),),
        BlocProvider(create: (context) => di.sl<ThemeCubit>(),),
      ],
      child: const OtlobAdminApp(),
    ),
  );
}

final _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
  ],
);

class OtlobAdminApp extends StatelessWidget {
  const OtlobAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, locale) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp.router(
              title: 'Otlob Admin',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              routerConfig: _router,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: locale,
            );
          },
        );
      },
    );
  }
}
