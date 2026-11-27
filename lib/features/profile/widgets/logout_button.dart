import 'package:material_ui/material_ui.dart';

import '../../auth/auth_providers.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});
  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  bool busy = false;
  Future<void> logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mau keluar akun?'),
        content: const Text(
          'Absensimu tetap tersimpan. Kamu bisa masuk lagi kapan saja.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Ya, keluar'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() => busy = true);
    try {
      await signOut();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Belum bisa keluar. Coba lagi, ya.')),
        );
      }
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => OutlinedButton.icon(
    onPressed: busy ? null : logout,
    icon: const Icon(Icons.logout),
    label: Text(busy ? 'Sebentar…' : 'Keluar akun'),
  );
}
