import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../profile/profile_page.dart';
import 'home_page.dart';
import 'history_page.dart';
import 'widgets/floating_nav.dart';

class ShellTabNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void setTab(int value) => state = value;
}

final shellTabIndexProvider =
    NotifierProvider.autoDispose<ShellTabNotifier, int>(ShellTabNotifier.new);

class AppShell extends ConsumerWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(shellTabIndexProvider);

    return Scaffold(
      extendBody: true,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: IndexedStack(
            index: index,
            children: const [HomePage(), HistoryPage(), ProfilePage()],
          ),
        ),
      ),
      bottomNavigationBar: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: FloatingNav(
          index: index,
          onChanged: (value) =>
              ref.read(shellTabIndexProvider.notifier).setTab(value),
        ),
      ),
    );
  }
}
