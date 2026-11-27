import 'package:material_ui/material_ui.dart';

class FloatingNav extends StatelessWidget {
  const FloatingNav({super.key, required this.index, required this.onChanged});

  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    const activeIcons = [
      Icons.home_rounded,
      Icons.history_rounded,
      Icons.person_rounded,
    ];
    const inactiveIcons = [
      Icons.home_outlined,
      Icons.history_rounded,
      Icons.person_outline_rounded,
    ];
    const labels = ['Beranda', 'Riwayat', 'Profil'];

    final activeColor = isDark ? Colors.white : const Color(0xFF141414);
    final inactiveColor = isDark
        ? Colors.white.withValues(alpha: 0.45)
        : const Color(0xFF7A7A7E);

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Center(
          heightFactor: 1,
          child: Container(
            width: 240, // Dibikin lebih ringkas biar nggak kopong
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              // Warna abu-abu lebih gelap & kontras dari background
              color: isDark ? const Color(0xFF262629) : const Color(0xFFE6E6E9),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.black.withValues(alpha: 0.08),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.12),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var i = 0; i < 3; i++)
                  Expanded(
                    child: Semantics(
                      label: labels[i],
                      selected: index == i,
                      button: true,
                      child: Tooltip(
                        message: labels[i],
                        child: InkWell(
                          borderRadius: BorderRadius.circular(999),
                          onTap: () => onChanged(i),
                          child: SizedBox(
                            height: double.infinity,
                            child: Center(
                              child: AnimatedScale(
                                scale: index == i ? 1.12 : 1.0,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeOutCubic,
                                child: Icon(
                                  index == i
                                      ? activeIcons[i]
                                      : inactiveIcons[i],
                                  size: 25,
                                  color: index == i
                                      ? activeColor
                                      : inactiveColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
