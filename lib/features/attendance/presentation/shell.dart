import 'package:material_ui/material_ui.dart';

import '../../profile/profile_page.dart';
import 'home_page.dart';
import 'history_page.dart';
import 'widgets/floating_nav.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int index = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: IndexedStack(
            index: index,
            children: const [HomePage(), HistoryPage(), ProfilePage()],
          ),
        ),
      ),
    ),
    bottomNavigationBar: FloatingNav(
      index: index,
      onChanged: (value) => setState(() => index = value),
    ),
  );
}
