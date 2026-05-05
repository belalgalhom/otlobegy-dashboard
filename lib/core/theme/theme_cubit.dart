import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final FlutterSecureStorage storage;

  ThemeCubit(this.storage) : super(ThemeMode.system) {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final themeName = await storage.read(key: 'theme_mode');
    if (themeName != null) {
      emit(ThemeMode.values.firstWhere(
        (e) => e.name == themeName,
        orElse: () => ThemeMode.system,
      ));
    }
  }

  Future<void> toggleTheme() async {
    final newMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await storage.write(key: 'theme_mode', value: newMode.name);
    emit(newMode);
  }

  Future<void> setTheme(ThemeMode mode) async {
    await storage.write(key: 'theme_mode', value: mode.name);
    emit(mode);
  }
}
