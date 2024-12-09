import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';

import 'core/routing/app_router.dart';
import 'core/theme/app_themes.dart';
import 'core/localization/app_localizations.dart';

void main() {
  // Initialize media_kit
  MediaKit.ensureInitialized();
  
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const ProviderScope(
        child: SocialMediaApp(),
      ),
    ),
  );
}

class SocialMediaApp extends ConsumerWidget {
  const SocialMediaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final theme = ref.watch(themeProvider);
    final locale = ref.watch(localizationProvider);

    return MaterialApp.router(
      title: 'Omniversify',
      theme: theme,
      routerConfig: router,
      
      // Localization configuration
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales.values.toList(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      
      // Debugging banner
      debugShowCheckedModeBanner: false,
      
    );
  }
}
