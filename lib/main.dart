import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/omniversify_cupertino_localizations.dart';
import 'core/omniversify_material_localizations.dart';
import 'core/omniversify_widgets_localizations.dart';
import 'l10n/app_localizations.dart';
import 'providers/theme_provider.dart';
import 'router.dart';

// Providers
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

void main() {
  MediaKit.ensureInitialized();

  runApp(
    const ProviderScope(
      child: SocialMediaApp(),
    ),
  );
}

class SocialMediaApp extends ConsumerWidget {
  const SocialMediaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: AppLocalizations.of(context)?.app_title ?? 'Omniversify',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        OmniversifyMaterialLocalizations.delegate,
        OmniversifyWidgetsLocalizations.delegate,
        OmniversifyCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
      themeMode: themeMode,
      theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.tajawalTextTheme(ThemeData.light().textTheme),
      ),
      darkTheme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.tajawalTextTheme(ThemeData.dark().textTheme),
      ),
      locale: locale,
    );
  }
}
