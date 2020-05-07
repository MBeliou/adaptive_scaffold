
part of adaptive_scaffold;

/// BottomNavBarTheme is a placeholder for the BottomNavigationBar theme until flutter 1.18.0-pre6 becomes mainstream
/// 
/// /!\ No initial value is given. When used in [AdaptiveScaffold], values that are not set have been matched to the closest meaningful [Theme] property I could think of. See [_AdaptiveScaffoldState]'s small screen builder to see said values.
/// 
/// TODO: Remove when flutter 1.18 comes around
@immutable
class BottomNavBarThemeData {
  const BottomNavBarThemeData({
    this.backgroundColor,
    this.elevation,
    this.selectedIconTheme,
    this.unselectedIconTheme,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.showSelectedLabels,
    this.showUnselectedLabels,
  });

  /// The color of the [BottomNavigationBar] itself.
  ///
  /// See [BottomNavigationBar.backgroundColor].
  final Color backgroundColor;

  /// The z-coordinate of the [BottomNavigationBar].
  ///
  /// See [BottomNavigationBar.elevation].
  final double elevation;

  /// The size, opacity, and color of the icon in the currently selected
  /// [BottomNavigationBarItem.icon].
  ///
  /// See [BottomNavigationBar.selectedIconTheme].
  final IconThemeData selectedIconTheme;

  /// The size, opacity, and color of the icon in the currently unselected
  /// [BottomNavigationBarItem.icon]s.
  ///
  /// See [BottomNavigationBar.unselectedIconTheme].
  final IconThemeData unselectedIconTheme;

  /// The color of the selected [BottomNavigationBarItem.icon] and
  /// [BottomNavigationBarItem.label].
  ///
  /// See [BottomNavigationBar.selectedItemColor].
  final Color selectedItemColor;

  /// The color of the unselected [BottomNavigationBarItem.icon] and
  /// [BottomNavigationBarItem.label]s.
  ///
  /// See [BottomNavigationBar.unselectedItemColor].
  final Color unselectedItemColor;

  /// The [TextStyle] of the [BottomNavigationBarItem] labels when they are
  /// selected.
  ///
  /// See [BottomNavigationBar.selectedLabelStyle].
  final TextStyle selectedLabelStyle;

  /// The [TextStyle] of the [BottomNavigationBarItem] labels when they are not
  /// selected.
  ///
  /// See [BottomNavigationBar.unselectedLabelStyle].
  final TextStyle unselectedLabelStyle;

  /// Whether the labels are shown for the unselected [BottomNavigationBarItem]s.
  ///
  /// See [BottomNavigationBar.showSelectedLabels].
  final bool showSelectedLabels;

  /// Whether the labels are shown for the selected [BottomNavigationBarItem].
  ///
  /// See [BottomNavigationBar.showUnselectedLabels].
  final bool showUnselectedLabels;

  /// Creates a copy of this object but with the given fields replaced with the
  /// new values.
  BottomNavBarThemeData copyWith({
    Color backgroundColor,
    double elevation,
    IconThemeData selectedIconTheme,
    IconThemeData unselectedIconTheme,
    Color selectedItemColor,
    Color unselectedItemColor,
    TextStyle selectedLabelStyle,
    TextStyle unselectedLabelStyle,
    bool showSelectedLabels,
    bool showUnselectedLabels,
  }) {
    return BottomNavBarThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      elevation: elevation ?? this.elevation,
      selectedIconTheme: selectedIconTheme ?? this.selectedIconTheme,
      unselectedIconTheme: unselectedIconTheme ?? this.unselectedIconTheme,
      selectedItemColor: selectedItemColor ?? this.selectedItemColor,
      unselectedItemColor: unselectedItemColor ?? this.unselectedItemColor,
      selectedLabelStyle: selectedLabelStyle ?? this.selectedLabelStyle,
      unselectedLabelStyle: unselectedLabelStyle ?? this.unselectedLabelStyle,
      showSelectedLabels: showSelectedLabels ?? this.showSelectedLabels,
      showUnselectedLabels: showUnselectedLabels ?? this.showUnselectedLabels,
    );
  }
}
