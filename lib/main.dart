import 'package:firebase_core/firebase_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // memastikan semua widget ke render/bind
  await initializeDateFormatting('id'); // format date indonesia
  Object? startupError;
  try {
    // TODO-F01: Tambahkan import firebase_core dan inisialisasi Firebase.
    // Konfigurasi native diunduh dari Console; tanpa Firebase CLI.
    await Firebase.initializeApp();
  } catch (error) {
    startupError = error; // menyimpan logs kalau app kita error
  }
  runApp(ProviderScope(child: TjekApp(startupError: startupError)));
}
