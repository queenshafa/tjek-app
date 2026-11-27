import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_header.dart';
import 'login_fields.dart';
import 'auth_repository.dart';
import '../../core/surface_card.dart';
import '../../core/enter_motion.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final email = TextEditingController(), password = TextEditingController();
  bool busy = false;
  String? error;
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> login() async {
    setState(() {
      busy = true;
      error = null;
    });
    try {
      await ref
          .read(authRepositoryProvider)
          .signIn(email.text.trim(), password.text);
    } on FirebaseAuthException {
      if (mounted) {
        setState(() => error = 'Login gagal. Periksa akun dan koneksi kamu.');
      }
    } catch (_) {
      if (mounted) setState(() => error = 'Belum bisa masuk. Coba lagi.');
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: EnterMotion(
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LoginHeader(),
                  SurfaceCard(
                    child: LoginFields(email: email, password: password),
                  ),
                  const SizedBox(height: 24),
                  if (error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        error!,
                        style: const TextStyle(color: Colors.orangeAccent),
                      ),
                    ),
                  FilledButton(
                    onPressed: busy ? null : login,
                    child: Text(busy ? 'Menghubungkan…' : 'Masuk →'),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Belum punya akun? Minta ke admin sekolah, ya.',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
