import 'package:flutter/material.dart';

/// Configuration for a single tab in the WindowsStyleTabView.
class WindowsStyleTab {
  /// The title/label for this tab
  final String title;

  /// The icon to display next to the title
  final IconData icon;

  /// The content widget to show when this tab is selected
  final Widget content;

  const WindowsStyleTab({
    required this.title,
    required this.icon,
    required this.content,
  });
}

/// A Windows-style tab view widget with customizable styling.
///
/// Provides a tab interface similar to Windows tabs with customizable
/// colors for selected/unselected states. The content switches instantly
/// with no sliding animation.
class WindowsStyleTabView extends StatefulWidget {
  /// The tabs to display
  final List<WindowsStyleTab> tabs;

  /// Tab bar background color
  final Color tabBarBackgroundColor;

  /// Tab bar border color
  final Color tabBarBorderColor;

  /// Selected tab color
  final Color selectedTabColor;

  /// Unselected tab color
  final Color unselectedTabColor;

  /// Selected tab text color
  final Color selectedTabTextColor;

  /// Unselected tab text color
  final Color unselectedTabTextColor;

  /// Optional callback when the selected tab changes
  final void Function(int index)? onTabChanged;

  /// Initially selected tab index (default: 0)
  final int initialIndex;

  /// Optional controlled selected tab index. When provided, the parent
  /// controls which tab is selected. Otherwise, the widget manages its own state.
  final int? selectedIndex;

  const WindowsStyleTabView({
    super.key,
    required this.tabs,
    this.tabBarBackgroundColor = const Color(0xFF2D2D2D),
    this.tabBarBorderColor = const Color(0xFF1E1E1E),
    this.selectedTabColor = const Color(0xFF3C3C3C),
    this.unselectedTabColor = const Color(0xFF2D2D2D),
    this.selectedTabTextColor = Colors.white,
    this.unselectedTabTextColor = const Color(0xFF9E9E9E),
    this.onTabChanged,
    this.initialIndex = 0,
    this.selectedIndex,
  });

  @override
  State<WindowsStyleTabView> createState() => _WindowsStyleTabViewState();
}

class _WindowsStyleTabViewState extends State<WindowsStyleTabView> {
  int? _selectedIndex;

  int get selectedIndex => widget.selectedIndex ?? _selectedIndex ?? widget.initialIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _selectTab(int index) {
    if (selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      widget.onTabChanged?.call(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = this.selectedIndex;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTabBar(),
        Expanded(
          child: IndexedStack(
            index: selectedIndex,
            children: widget.tabs.map((tab) => tab.content).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    final selectedIndex = this.selectedIndex;
    return Container(
      height: 28,
      padding: const EdgeInsets.only(left: 8, top: 4),
      decoration: BoxDecoration(
        color: widget.tabBarBackgroundColor,
        border: Border(
          bottom: BorderSide(color: widget.tabBarBorderColor, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (int i = 0; i < widget.tabs.length; i++) ...[
            _buildTab(
              title: widget.tabs[i].title,
              icon: widget.tabs[i].icon,
              index: i,
              selectedIndex: selectedIndex,
            ),
            if (i < widget.tabs.length - 1) const SizedBox(width: 2),
          ],
        ],
      ),
    );
  }

  Widget _buildTab({
    required String title,
    required IconData icon,
    required int index,
    required int selectedIndex,
  }) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => _selectTab(index),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 24,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: isSelected ? widget.selectedTabColor : widget.unselectedTabColor,
            border: Border(
              top: BorderSide(
                color: isSelected ? widget.tabBarBorderColor : Colors.transparent,
                width: 1,
              ),
              left: BorderSide(
                color: isSelected ? widget.tabBarBorderColor : Colors.transparent,
                width: 1,
              ),
              right: BorderSide(
                color: isSelected ? widget.tabBarBorderColor : Colors.transparent,
                width: 1,
              ),
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(3),
              topRight: Radius.circular(3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 12,
                color: isSelected
                    ? widget.selectedTabTextColor
                    : widget.unselectedTabTextColor,
              ),
              const SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  color: isSelected
                      ? widget.selectedTabTextColor
                      : widget.unselectedTabTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
