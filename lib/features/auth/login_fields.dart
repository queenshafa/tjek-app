import 'package:material_ui/material_ui.dart';

class LoginFields extends StatefulWidget {
  const LoginFields({super.key, required this.email, required this.password});
  final TextEditingController email, password;
  @override
  State<LoginFields> createState() => _LoginFieldsState();
}

class _LoginFieldsState extends State<LoginFields> {
  bool hidden = true;
  @override
  Widget build(BuildContext context) => Column(
    children: [
      TextField(
        controller: widget.email,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        autofillHints: const [AutofillHints.email],
        decoration: const InputDecoration(labelText: 'Email sekolah'),
      ),
      const SizedBox(height: 14),
      TextField(
        controller: widget.password,
        obscureText: hidden,
        autocorrect: false,
        enableSuggestions: false,
        autofillHints: const [AutofillHints.password],
        decoration: InputDecoration(
          labelText: 'Kata sandi',
          suffixIcon: IconButton(
            tooltip: hidden ? 'Lihat kata sandi' : 'Sembunyikan kata sandi',
            onPressed: () => setState(() => hidden = !hidden),
            icon: Icon(
              hidden
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
          ),
        ),
      ),
    ],
  );
}
