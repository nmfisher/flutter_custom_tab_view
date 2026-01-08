import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'windows_style_tab_view_theme.dart';

/// A builder function for creating a custom tab header layout.
///
/// The [buildTab] helper creates a tab widget with proper styling for the
/// current theme. You can use it to build individual tabs while maintaining
/// consistent appearance, or build your own tabs from scratch.
///
/// Example:
/// ```dart
/// tabHeaderLayout: (context, tabs, selectedIndex, buildTab) => Row(
///   children: [
///     ...tabs.asMap().entries.map((entry) {
///       final index = entry.key;
///       final tab = entry.value;
///       return buildTab(index, tab);
///     }),
///     const Spacer(),
///     MenuAnchor(...),
///   ],
/// )
/// ```
typedef TabHeaderLayoutBuilder = Widget Function(
  BuildContext context,
  List<WindowsStyleTab> tabs,
  int selectedIndex,
  /// Helper to build a tab with proper styling.
  /// Use this to ensure your custom tabs have the correct appearance.
  Widget Function(
    int index,
    WindowsStyleTab tab, {
    VoidCallback? onTap,
  }) buildTab,
);

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
///
/// ## Using Mix Themes
///
/// ```dart
/// WindowsStyleTabView(
///   theme: WindowsStyleTabViewTheme.dark(),
///   tabs: [...],
/// )
/// ```
///
/// ## Using Individual Colors (Backward Compatible)
///
/// ```dart
/// WindowsStyleTabView(
///   tabBarBackgroundColor: Colors.grey[900],
///   selectedTabColor: Colors.blue,
///   tabs: [...],
/// )
/// ```
///
/// ## Combining Theme and Individual Colors
///
/// Individual color parameters will override theme colors:
/// ```dart
/// WindowsStyleTabView(
///   theme: WindowsStyleTabViewTheme.dark(),
///   selectedTabColor: Colors.red, // Overrides the dark theme's selected color
///   tabs: [...],
/// )
/// ```
class WindowsStyleTabView extends StatefulWidget {
  /// The tabs to display
  final List<WindowsStyleTab> tabs;

  /// Mix theme for styling the tab view
  final WindowsStyleTabViewTheme? theme;

  /// Tab bar background color (overrides theme)
  final Color? tabBarBackgroundColor;

  /// Tab bar border color (overrides theme)
  final Color? tabBarBorderColor;

  /// Selected tab color (overrides theme)
  final Color? selectedTabColor;

  /// Unselected tab color (overrides theme)
  final Color? unselectedTabColor;

  /// Selected tab text color (overrides theme)
  final Color? selectedTabTextColor;

  /// Unselected tab text color (overrides theme)
  final Color? unselectedTabTextColor;

  /// Optional callback when the selected tab changes
  final void Function(int index)? onTabChanged;

  /// Initially selected tab index (default: 0)
  final int initialIndex;

  /// Optional controlled selected tab index. When provided, the parent
  /// controls which tab is selected. Otherwise, the widget manages its own state.
  final int? selectedIndex;

  /// Optional custom builder for the tab header layout.
  ///
  /// When provided, this function is called instead of the default Row layout,
  /// allowing you to completely customize how tabs and other widgets are arranged
  /// in the header. You can add custom widgets like menu anchors, buttons, etc.
  ///
  /// The [buildTab] helper creates a tab widget with proper styling for the
  /// current theme.
  final TabHeaderLayoutBuilder? tabHeaderLayout;

  const WindowsStyleTabView({
    super.key,
    required this.tabs,
    this.theme,
    // Deprecated individual color parameters (still supported for backward compatibility)
    this.tabBarBackgroundColor,
    this.tabBarBorderColor,
    this.selectedTabColor,
    this.unselectedTabColor,
    this.selectedTabTextColor,
    this.unselectedTabTextColor,
    this.onTabChanged,
    this.initialIndex = 0,
    this.selectedIndex,
    this.tabHeaderLayout,
  });

  /// Creates a WindowsStyleTabView with default dark theme values
  factory WindowsStyleTabView.withDefaults({
    Key? key,
    required List<WindowsStyleTab> tabs,
    Color tabBarBackgroundColor = const Color(0xFF2D2D2D),
    Color tabBarBorderColor = const Color(0xFF1E1E1E),
    Color selectedTabColor = const Color(0xFF3C3C3C),
    Color unselectedTabColor = const Color(0xFF2D2D2D),
    Color selectedTabTextColor = Colors.white,
    Color unselectedTabTextColor = const Color(0xFF9E9E9E),
    void Function(int index)? onTabChanged,
    int initialIndex = 0,
    int? selectedIndex,
  }) {
    return WindowsStyleTabView(
      key: key,
      tabs: tabs,
      tabBarBackgroundColor: tabBarBackgroundColor,
      tabBarBorderColor: tabBarBorderColor,
      selectedTabColor: selectedTabColor,
      unselectedTabColor: unselectedTabColor,
      selectedTabTextColor: selectedTabTextColor,
      unselectedTabTextColor: unselectedTabTextColor,
      onTabChanged: onTabChanged,
      initialIndex: initialIndex,
      selectedIndex: selectedIndex,
    );
  }

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

  // Style getters

  WindowsStyleTabViewTheme get _defaultTheme => WindowsStyleTabViewTheme.dark();

  BoxStyler get _tabBarStyle {
    final baseStyle = widget.theme?.tabBarStyle ?? _defaultTheme.tabBarStyle;
    if (widget.tabBarBackgroundColor != null) {
      baseStyle.color(widget.tabBarBackgroundColor!);
    }
    if (widget.tabBarBorderColor != null) {
      baseStyle.borderBottom(
        color: widget.tabBarBorderColor!,
        width: 1,
      );
    }
    return baseStyle;
  }

  BoxStyler get _tabStyle => widget.theme?.tabStyle ?? _defaultTheme.tabStyle;

  BoxStyler get _selectedTabBoxStyle {
    final baseStyle = widget.theme?.selectedTabBoxStyle ?? _defaultTheme.selectedTabBoxStyle;
    if (widget.selectedTabColor != null) {
      return baseStyle.color(widget.selectedTabColor!);
    }
    if (widget.tabBarBorderColor != null) {
      return baseStyle
          .borderTop(color: widget.tabBarBorderColor!, width: 1)
          .borderLeft(color: widget.tabBarBorderColor!, width: 1)
          .borderRight(color: widget.tabBarBorderColor!, width: 1);
    }
    return baseStyle;
  }

  BoxStyler get _unselectedTabBoxStyle {
    final baseStyle = widget.theme?.unselectedTabBoxStyle ?? _defaultTheme.unselectedTabBoxStyle;
    if (widget.unselectedTabColor != null) {
      return baseStyle.color(widget.unselectedTabColor!);
    }
    return baseStyle;
  }

  TextStyler get _selectedTabTextStyle {
    final baseStyle = widget.theme?.selectedTabTextStyle ?? _defaultTheme.selectedTabTextStyle;
    if (widget.selectedTabTextColor != null) {
      return baseStyle.color(widget.selectedTabTextColor!);
    }
    return baseStyle;
  }

  TextStyler get _unselectedTabTextStyle {
    final baseStyle = widget.theme?.unselectedTabTextStyle ?? _defaultTheme.unselectedTabTextStyle;
    if (widget.unselectedTabTextColor != null) {
      return baseStyle.color(widget.unselectedTabTextColor!);
    }
    return baseStyle;
  }

  IconStyler get _selectedTabIconStyle {
    final baseStyle = widget.theme?.selectedTabIconStyle ?? _defaultTheme.selectedTabIconStyle;
    if (widget.selectedTabTextColor != null) {
      return baseStyle.color(widget.selectedTabTextColor!);
    }
    return baseStyle;
  }

  IconStyler get _unselectedTabIconStyle {
    final baseStyle = widget.theme?.unselectedTabIconStyle ?? _defaultTheme.unselectedTabIconStyle;
    if (widget.unselectedTabTextColor != null) {
      return baseStyle.color(widget.unselectedTabTextColor!);
    }
    return baseStyle;
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = this.selectedIndex;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTabBar(selectedIndex),
        Expanded(
          child: IndexedStack(
            index: selectedIndex,
            children: widget.tabs.map((tab) => tab.content).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar(int selectedIndex) {
    if (widget.tabHeaderLayout != null) {
      return Box(
        style: _tabBarStyle,
        child: widget.tabHeaderLayout!(
          context,
          widget.tabs,
          selectedIndex,
          _buildTabWidget,
        ),
      );
    }

    return Box(
      style: _tabBarStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (int i = 0; i < widget.tabs.length; i++) ...[
            _buildTabWidget(i, widget.tabs[i]),
            if (i < widget.tabs.length - 1) Box(style: $box.width(2)),
          ],
        ],
      ),
    );
  }

  /// Helper function to build a styled tab widget.
  /// Used by the default tab bar and provided to [tabHeaderLayout] for custom layouts.
  Widget _buildTabWidget(int index, WindowsStyleTab tab, {VoidCallback? onTap}) {
    final isSelected = index == selectedIndex;
    return _StyledTab(
      title: tab.title,
      icon: tab.icon,
      index: index,
      isSelected: isSelected,
      tabStyle: _tabStyle,
      selectedBoxStyle: _selectedTabBoxStyle,
      unselectedBoxStyle: _unselectedTabBoxStyle,
      selectedTextStyle: _selectedTabTextStyle,
      unselectedTextStyle: _unselectedTabTextStyle,
      selectedIconStyle: _selectedTabIconStyle,
      unselectedIconStyle: _unselectedTabIconStyle,
      onTap: onTap ?? () => _selectTab(index),
    );
  }
}

/// A styled tab widget used internally by [WindowsStyleTabView]
class _StyledTab extends StatelessWidget {
  final String title;
  final IconData icon;
  final int index;
  final bool isSelected;
  final BoxStyler tabStyle;
  final BoxStyler selectedBoxStyle;
  final BoxStyler unselectedBoxStyle;
  final TextStyler selectedTextStyle;
  final TextStyler unselectedTextStyle;
  final IconStyler selectedIconStyle;
  final IconStyler unselectedIconStyle;
  final VoidCallback onTap;

  const _StyledTab({
    required this.title,
    required this.icon,
    required this.index,
    required this.isSelected,
    required this.tabStyle,
    required this.selectedBoxStyle,
    required this.unselectedBoxStyle,
    required this.selectedTextStyle,
    required this.unselectedTextStyle,
    required this.selectedIconStyle,
    required this.unselectedIconStyle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final boxStyle = isSelected ? selectedBoxStyle : unselectedBoxStyle;
    final textStyle = isSelected ? selectedTextStyle : unselectedTextStyle;
    final iconStyle = isSelected ? selectedIconStyle : unselectedIconStyle;

    return Box(
      style: tabStyle.merge(boxStyle),
      child: PressableBox(
        onPress: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            StyledIcon(icon: icon, style: iconStyle),
            Box(style: $box.width(4)),
            StyledText(title, style: textStyle),
          ],
        ),
      ),
    );
  }
}
