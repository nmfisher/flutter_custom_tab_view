import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

/// Theme configuration for [WindowsStyleTabView] with Mix styling.
///
/// Provides preset themes and supports merging for customization.
class WindowsStyleTabViewTheme {
  /// Style for the tab bar container
  final BoxStyler tabBarStyle;

  /// Base style for all tabs (shared by selected and unselected)
  final BoxStyler tabStyle;

  /// Box style for selected tabs
  final BoxStyler selectedTabBoxStyle;

  /// Box style for unselected tabs
  final BoxStyler unselectedTabBoxStyle;

  /// Text style for selected tabs
  final TextStyler selectedTabTextStyle;

  /// Text style for unselected tabs
  final TextStyler unselectedTabTextStyle;

  /// Icon style for selected tabs
  final IconStyler selectedTabIconStyle;

  /// Icon style for unselected tabs
  final IconStyler unselectedTabIconStyle;

  const WindowsStyleTabViewTheme({
    required this.tabBarStyle,
    required this.tabStyle,
    required this.selectedTabBoxStyle,
    required this.unselectedTabBoxStyle,
    required this.selectedTabTextStyle,
    required this.unselectedTabTextStyle,
    required this.selectedTabIconStyle,
    required this.unselectedTabIconStyle,
  });

  /// Dark theme preset (matches the original default appearance)
  factory WindowsStyleTabViewTheme.dark() {
    const selectedColor = Color(0xFF3C3C3C);
    const unselectedColor = Color(0xFF2D2D2D);
    const borderColor = Color(0xFF1E1E1E);
    const backgroundColor = Color(0xFF2D2D2D);
    const selectedTextColor = Colors.white;
    const unselectedTextColor = Color(0xFF9E9E9E);

    return WindowsStyleTabViewTheme(
      tabBarStyle: $box
          .height(28)
          .paddingOnly(left: 8, top: 4)
          .color(backgroundColor)
          .borderBottom(color: borderColor, width: 1),
      tabStyle: $box
          .height(24)
          .paddingX(8)
          .paddingY(2)
          .borderRadiusTopLeft(const Radius.circular(3))
          .borderRadiusTopRight(const Radius.circular(3)),
      selectedTabBoxStyle: $box
          .color(selectedColor)
          .borderTop(color: borderColor, width: 1)
          .borderLeft(color: borderColor, width: 1)
          .borderRight(color: borderColor, width: 1),
      unselectedTabBoxStyle: $box.color(unselectedColor),
      selectedTabTextStyle: $text.style.color(selectedTextColor).fontSize(11),
      unselectedTabTextStyle: $text.style.color(unselectedTextColor).fontSize(11),
      selectedTabIconStyle: $icon.size(12).color(selectedTextColor),
      unselectedTabIconStyle: $icon.size(12).color(unselectedTextColor),
    );
  }

  /// Light theme preset
  factory WindowsStyleTabViewTheme.light() {
    const selectedColor = Colors.white;
    const unselectedColor = Color(0xFFE8E8E8);
    const borderColor = Color(0xFFE0E0E0);
    const backgroundColor = Color(0xFFF5F5F5);
    const selectedTextColor = Colors.black;
    const unselectedTextColor = Colors.black54;

    return WindowsStyleTabViewTheme(
      tabBarStyle: $box
          .height(28)
          .paddingOnly(left: 8, top: 4)
          .color(backgroundColor)
          .borderBottom(color: borderColor, width: 1),
      tabStyle: $box
          .height(24)
          .paddingX(8)
          .paddingY(2)
          .borderRadiusTopLeft(const Radius.circular(3))
          .borderRadiusTopRight(const Radius.circular(3)),
      selectedTabBoxStyle: $box
          .color(selectedColor)
          .borderTop(color: borderColor, width: 1)
          .borderLeft(color: borderColor, width: 1)
          .borderRight(color: borderColor, width: 1),
      unselectedTabBoxStyle: $box.color(unselectedColor),
      selectedTabTextStyle: $text.style.color(selectedTextColor).fontSize(11),
      unselectedTabTextStyle: $text.style.color(unselectedTextColor).fontSize(11),
      selectedTabIconStyle: $icon.size(12).color(selectedTextColor),
      unselectedTabIconStyle: $icon.size(12).color(unselectedTextColor),
    );
  }

  /// Blue theme preset
  factory WindowsStyleTabViewTheme.blue() {
    const selectedColor = Color(0xFF283593);
    const unselectedColor = Color(0xFF1A237E);
    const borderColor = Color(0xFF1A237E);
    const backgroundColor = Color(0xFF1A237E);
    const selectedTextColor = Colors.white;
    const unselectedTextColor = Color(0xFF90CAF9);

    return WindowsStyleTabViewTheme(
      tabBarStyle: $box
          .height(28)
          .paddingOnly(left: 8, top: 4)
          .color(backgroundColor)
          .borderBottom(color: borderColor, width: 1),
      tabStyle: $box
          .height(24)
          .paddingX(8)
          .paddingY(2)
          .borderRadiusTopLeft(const Radius.circular(3))
          .borderRadiusTopRight(const Radius.circular(3)),
      selectedTabBoxStyle: $box
          .color(selectedColor)
          .borderTop(color: borderColor, width: 1)
          .borderLeft(color: borderColor, width: 1)
          .borderRight(color: borderColor, width: 1),
      unselectedTabBoxStyle: $box.color(unselectedColor),
      selectedTabTextStyle: $text.style.color(selectedTextColor).fontSize(11),
      unselectedTabTextStyle: $text.style.color(unselectedTextColor).fontSize(11),
      selectedTabIconStyle: $icon.size(12).color(selectedTextColor),
      unselectedTabIconStyle: $icon.size(12).color(unselectedTextColor),
    );
  }

  /// Merges this theme with another, allowing for partial customization.
  ///
  /// Styles from [other] will override styles from this theme.
  /// Null styles in [other] will not override.
  WindowsStyleTabViewTheme mergeWith(WindowsStyleTabViewTheme? other) {
    if (other == null) return this;

    return WindowsStyleTabViewTheme(
      tabBarStyle: tabBarStyle.merge(other.tabBarStyle),
      tabStyle: tabStyle.merge(other.tabStyle),
      selectedTabBoxStyle: selectedTabBoxStyle.merge(other.selectedTabBoxStyle),
      unselectedTabBoxStyle: unselectedTabBoxStyle.merge(other.unselectedTabBoxStyle),
      selectedTabTextStyle: selectedTabTextStyle.merge(other.selectedTabTextStyle),
      unselectedTabTextStyle: unselectedTabTextStyle.merge(other.unselectedTabTextStyle),
      selectedTabIconStyle: selectedTabIconStyle.merge(other.selectedTabIconStyle),
      unselectedTabIconStyle: unselectedTabIconStyle.merge(other.unselectedTabIconStyle),
    );
  }
}
