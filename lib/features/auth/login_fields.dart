import 'package:material_ui/material_ui.dart';

class LoginFields extends StatefulWidget {
  const LoginFields({
    super.key,
    required this.email,
    required this.password,
    this.onSubmitted,
  });

  final TextEditingController email, password;
  final VoidCallback? onSubmitted;

  @override
  State<LoginFields> createState() => _LoginFieldsState();
}

class _LoginFieldsState extends State<LoginFields> {
  bool hidden = true;
  static const _orange = Color(0xFFED7014);

  InputDecoration _fieldDecoration({
    required String hint,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: Colors.white.withValues(alpha: 0.45),
        fontSize: 14,
      ),
      prefixIcon: Icon(prefixIcon, color: _orange, size: 20),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.08),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _orange, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Akun Sekolah',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Gunakan email dan kata sandi yang terdaftar.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.65),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 18),
        TextField(
          controller: widget.email,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autocorrect: false,
          autofillHints: const [AutofillHints.email],
          style: const TextStyle(color: Colors.white, fontSize: 14),
          cursorColor: _orange,
          decoration: _fieldDecoration(
            hint: 'Email sekolah',
            prefixIcon: Icons.alternate_email_rounded,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: widget.password,
          obscureText: hidden,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => widget.onSubmitted?.call(),
          autocorrect: false,
          enableSuggestions: false,
          autofillHints: const [AutofillHints.password],
          style: const TextStyle(color: Colors.white, fontSize: 14),
          cursorColor: _orange,
          decoration: _fieldDecoration(
            hint: 'Kata sandi',
            prefixIcon: Icons.lock_outline_rounded,
            suffixIcon: IconButton(
              tooltip: hidden ? 'Lihat kata sandi' : 'Sembunyikan kata sandi',
              onPressed: () => setState(() => hidden = !hidden),
              icon: Icon(
                hidden
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.white.withValues(alpha: 0.6),
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
