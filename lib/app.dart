import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme.dart';
import 'core/atmosphere.dart';
import 'core/theme_provider.dart';
import 'features/auth/auth_providers.dart';
import 'features/auth/login_page.dart';
import 'features/attendance/presentation/shell.dart';

class TjekApp extends ConsumerWidget {
  const TjekApp({super.key, this.startupError});
  final Object? startupError;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider).asData?.value ?? ThemeMode.light;

    return MaterialApp(
      title: 'Tjek',
      builder: (_, child) => Atmosphere(child: child!),
      debugShowCheckedModeBanner: false,
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      themeMode: themeMode,
      home: startupError != null
          ? const Scaffold(
              body: Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Text(
                    'Firebase belum terhubung. Selesaikan TODO-F01; lihat docs/BRIEF-SISWA.pdf.',
                  ),
                ),
              ),
            )
          : ref
                .watch(sessionProvider)
                .when(
                  loading: () => const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  ),
                  error: (_, _) => const Scaffold(
                    body: Center(
                      child: Text('Gagal membaca sesi. Mulai ulang aplikasi.'),
                    ),
                  ),
                  data: (signedIn) =>
                      signedIn ? const AppShell() : const LoginPage(),
                ),
    );
  }
}
