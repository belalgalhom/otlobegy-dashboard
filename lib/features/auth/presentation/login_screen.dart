import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:otlob_admin/features/auth/presentation/auth_bloc.dart';
import 'package:otlob_admin/injection_container.dart';
import 'package:otlob_admin/generated/l10n/app_localizations.dart';
import 'package:otlob_admin/core/localization/language_cubit.dart';
import 'package:otlob_admin/core/theme/theme_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.go('/dashboard');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
            );
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              // Background Gradient
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Theme.of(context).colorScheme.background, Theme.of(context).colorScheme.surface],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              // Language Toggle in Top Corner
              Positioned(
                top: 40,
                right: 24,
                child: Row(
                  children: [
                    _buildThemeToggle(context),
                    const SizedBox(width: 8),
                    _buildLanguageToggle(context),
                  ],
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                            ),
                            child: const Icon(
                              LucideIcons.package,
                              color: AppColors.primary,
                              size: 48,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Center(
                          child: Text(
                            'Otlob Admin', // Keep app name or translate if needed. Using a key for flexibility.
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),
                        Text(
                          AppLocalizations.of(context)!.emailAddress,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.emailHint,
                            prefixIcon: const Icon(LucideIcons.mail, size: 20),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          AppLocalizations.of(context)!.password,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: '••••••••',
                            prefixIcon: const Icon(LucideIcons.lock, size: 20),
                          ),
                        ),
                        const SizedBox(height: 32),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: state is AuthLoading
                                    ? null
                                    : () {
                                        context.read<AuthBloc>().add(
                                              LoginSubmitted(
                                                _emailController.text,
                                                _passwordController.text,
                                              ),
                                            );
                                      },
                                child: state is AuthLoading
                                    ? const CircularProgressIndicator(color: Colors.white)
                                    : Text(AppLocalizations.of(context)!.signIn),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return InkWell(
          onTap: () => context.read<ThemeCubit>().toggleTheme(),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1)),
            ),
            child: Icon(
              isDark ? LucideIcons.sun : LucideIcons.moon,
              size: 16,
              color: Colors.amber,
            ),
          ),
        );
      },
    );
  }

  Widget _buildLanguageToggle(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, locale) {
        final isArabic = locale.languageCode == 'ar';
        return InkWell(
          onTap: () => context.read<LanguageCubit>().toggleLanguage(),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.surface.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(LucideIcons.languages, size: 16, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  isArabic ? 'EN' : 'AR',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
