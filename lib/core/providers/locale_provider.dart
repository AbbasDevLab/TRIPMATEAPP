import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('en', 'US')) {
    // Load locale asynchronously to avoid blocking main thread
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    try {
      // Use compute or schedule microtask to avoid blocking
      final prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString('language_code') ?? 'en';
      final countryCode = prefs.getString('country_code') ?? 'US';
      final loadedLocale = Locale(languageCode, countryCode);
      // Update state asynchronously
      state = loadedLocale;
    } catch (e) {
      // Keep default locale on error
      print('⚠️ Failed to load locale: $e');
    }
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);
    await prefs.setString('country_code', locale.countryCode ?? 'US');
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>(
  (ref) => LocaleNotifier(),
);

