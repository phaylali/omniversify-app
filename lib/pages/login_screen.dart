import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../l10n/app_localizations.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth =
                constraints.maxWidth > 600 ? 600.0 : constraints.maxWidth * 0.9;

            return SizedBox(
              width: maxWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SearchBar(
                    hintText: AppLocalizations.of(context)!.username,
                    padding: const WidgetStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    backgroundColor: WidgetStatePropertyAll<Color>(
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SearchBar(
                    hintText: AppLocalizations.of(context)!.password,
                    padding: const WidgetStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    backgroundColor: WidgetStatePropertyAll<Color>(
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize:
                          const Size.fromHeight(56), // Same height as SearchBar
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            28), // Same radius as SearchBar
                      ),
                    ),
                    onPressed: () => context.go('/'),
                    child: Text(AppLocalizations.of(context)!.signIn),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}