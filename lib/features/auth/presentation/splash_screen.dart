import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:otlob_admin/core/theme/app_theme.dart';
import 'package:otlob_admin/features/auth/data/auth_repository.dart';
import 'package:otlob_admin/features/auth/presentation/auth_bloc.dart';
import 'package:otlob_admin/injection_container.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    
    _controller.forward();
  }

  void _onAuthStateChanged(BuildContext context, AuthState state) {
    if (state is Authenticated) {
      context.go('/dashboard');
    } else if (state is Unauthenticated) {
      context.go('/login');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>()..add(AuthCheckRequested()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: _onAuthStateChanged,
        child: Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                ),
                child: const Icon(
                  LucideIcons.package,
                  color: AppColors.primary,
                  size: 64,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'OTLOB ADMIN',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 40,
                child: LinearProgressIndicator(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ),
);
}
}
