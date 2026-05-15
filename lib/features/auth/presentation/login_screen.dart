import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:otlob_admin/features/auth/presentation/auth_bloc.dart';
import 'package:otlob_admin/features/auth/data/auth_repository.dart';
import 'package:otlob_admin/injection_container.dart';
import 'package:otlob_admin/generated/l10n/app_localizations.dart';
import 'package:otlob_admin/core/localization/language_cubit.dart';
import 'package:otlob_admin/core/theme/theme_cubit.dart';
import 'package:otlob_admin/core/utils/error_utils.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _saveInfo = true;
  Map<String, String>? _savedProfile;

  @override
  void initState() {
    super.initState();
    _loadSavedProfile();
  }

  Future<void> _loadSavedProfile() async {
    final profile = await sl<AuthRepository>().getSavedProfile();
    if (profile != null) {
      setState(() {
        _savedProfile = profile;
        _emailController.text = profile['email'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: Builder(
        builder: (context) {
          return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is Authenticated) {
                if (_saveInfo) {
                  sl<AuthRepository>().saveProfileInfo(
                    _emailController.text,
                    _passwordController.text,
                    _emailController.text.split('@')[0],
                    'ADMIN'
                  );
                }
                context.go('/dashboard');
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(ErrorUtils.translate(context, state.message)), backgroundColor: AppColors.error),
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
                                'Otlob Admin',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.onBackground,
                                ),
                              ),
                            ),
                            const SizedBox(height: 48),
    
                            if (_savedProfile != null) ...[
                              InkWell(
                                onTap: () {
                                  final email = _savedProfile!['email'] ?? '';
                                  final password = _savedProfile!['password'] ?? '';
                                  _emailController.text = email;
                                  _passwordController.text = password;
                                  
                                  context.read<AuthBloc>().add(
                                    LoginSubmitted(
                                      email.trim().toLowerCase(),
                                      password,
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(20),
                                child: _buildSavedProfileCard(l10n),
                              ),
                              const SizedBox(height: 24),
                              Center(
                                child: Text(
                                  l10n.orLoginWithAnother,
                                  style: TextStyle(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5), fontSize: 14),
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],
    
                            Text(
                              l10n.emailAddress,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: l10n.emailHint,
                                prefixIcon: const Icon(LucideIcons.mail, size: 20),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              l10n.password,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                hintText: '••••••••',
                                prefixIcon: const Icon(LucideIcons.lock, size: 20),
                                suffixIcon: IconButton(
                                  icon: Icon(_obscurePassword ? LucideIcons.eye : LucideIcons.eyeOff, size: 20),
                                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                SizedBox(
                                  height: 24, width: 24,
                                  child: Checkbox(
                                    value: _saveInfo,
                                    onChanged: (v) => setState(() => _saveInfo = v ?? false),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () => setState(() => _saveInfo = !_saveInfo),
                                  child: Text(
                                    l10n.rememberMe,
                                    style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8)),
                                  ),
                                ),
                              ],
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
                                                    _emailController.text.trim().toLowerCase(),
                                                    _passwordController.text,
                                                  ),
                                                );
                                          },
                                    child: state is AuthLoading
                                        ? const CircularProgressIndicator(color: Colors.white)
                                        : Text(l10n.signIn),
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
          );
        }
      ),
    );
  }

  Widget _buildSavedProfileCard(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: Text(
              _savedProfile!['name']?[0].toUpperCase() ?? 'U',
              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _savedProfile!['name'] ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  _savedProfile!['email'] ?? '',
                  style: TextStyle(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6), fontSize: 13),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(LucideIcons.x, size: 18),
            onPressed: () async {
              await sl<AuthRepository>().deleteSavedProfile();
              setState(() {
                _savedProfile = null;
                _emailController.clear();
              });
            },
          ),
        ],
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
              color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
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
