import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LanguageCubit extends Cubit<Locale> {
  final FlutterSecureStorage storage;

  LanguageCubit(this.storage) : super(const Locale('ar')) {
    loadLanguage();
  }

  Future<void> loadLanguage() async {
    final languageCode = await storage.read(key: 'language_code');
    if (languageCode != null) {
      emit(Locale(languageCode));
    } else {
      emit(const Locale('ar')); // Default to Arabic
    }
  }

  Future<void> toggleLanguage() async {
    final newLocale = state.languageCode == 'ar' ? const Locale('en') : const Locale('ar');
    await storage.write(key: 'language_code', value: newLocale.languageCode);
    emit(newLocale);
  }

  Future<void> setLanguage(String languageCode) async {
    final newLocale = Locale(languageCode);
    await storage.write(key: 'language_code', value: languageCode);
    emit(newLocale);
  }
}
