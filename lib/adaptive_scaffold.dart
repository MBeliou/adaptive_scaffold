library adaptive_scaffold;

import 'package:flutter/material.dart';

part "bottom_navbar_theme.dart";


/// Describes the elevation of the NavigationRail
enum RailElevation {
  Backdrop,
  Divider,
  Elevated,
}

bool isLargeScreen(BuildContext context) {
  return MediaQuery.of(context).size.width > 960.0;
}

bool isMediumScreen(BuildContext context) {
  return MediaQuery.of(context).size.width > 640.0;
}

/// Describes the destination widgets and their placement in the responsive layout.
///
/// Use this class to configure the [AdaptiveScaffold] widget using:
///
/// * title is the name shown below the navigation icon or on the navigation drawer
/// * icon is [IconData], such as Icons.ac_unit
/// * destination is the [Widget] to be shown
/// * inDrawer is optional and set to false. If true and applicable, this will be set in the [Drawer]
class AdaptiveScaffoldDestination {
  final String title;
  final IconData icon;
  final bool inDrawer;
  final Widget destination;

  const AdaptiveScaffoldDestination({
    @required this.title,
    @required this.icon,
    @required this.destination,
    this.inDrawer = false,
  });
}

/// A scaffold widget that adapts to the current display size, displaying a [Drawer],
/// [NavigationRail], or [BottomNavigationBar]. Navigation destinations are
/// defined in the [destinations] parameter.
///
/// * title is the widget displayed in the [appBar]'s title widget field
/// * body is the shown widget. Note: Only Widgets registered in the [BottomNavigationBar] or the [NavigationRail] can be displayed directly. Others will be displayed using the [Navigator] and [MaterialPageRoute]
/// * railElevation uses the [RailElevation] enum to handle using the [NavigationRail] as a backdrop
/// * onNavigationIndexChange is a callback to be registered to handle navigation from the stateful parent. A sample implementation using an index would looks like:
///
/// ```dart
///   onNavigationIndexChange: (index) {
///      setState(() => currentIndex = index);
///   },
/// ```
/// 
/// NOTE: This will be removed when flutter 1.18 reaches stable and the BottomNavigationBar can be styled directly from Material's theme. 
/// * bottomNavigationThemeData is a [BottomNavBarThemeData] applied to the bottomNavBar.
///   Because of 
///
/// * activeDrawerItemDecoration is a [BoxDecoration] applied to the active drawer items. The following example adds a right side blue border to the active item:
///
///```dart
/// ...// Previous code
/// activeDrawerItemDecoration: BoxDecoration(
///   border: Border(
///     right: BorderSide(width: 6.0, color: Colors.blue),
/// ))
///```
///
/// * The drawer can be customized through drawerTheme using a [Theme]. the theme will default the context.
/// Consider using copyWith for easier tweaking.
/// ```dart
/// Theme.of(context).copyWith(
///   // Your theme data
///   canvasColor: Colors.yellow, // Will change the background Color
/// )
/// ```
///
/// General theming for the [NavigationRail]  is done through the Application's [ThemeData]
class AdaptiveScaffold extends StatefulWidget {
  final AppBar appBar;
  final Widget body;
  final RailElevation railElevation;
  final List<AdaptiveScaffoldDestination> destinations;
  final ValueChanged<int> onNavigationIndexChange;
  final FloatingActionButton floatingActionButton;

  final DrawerHeader drawerHeader;
  final ThemeData drawerThemeData;
  final BottomNavBarThemeData bottomNavigationThemeData;

  final int currentIndex;
  final BoxDecoration activeDrawerItemDecoration;

  AdaptiveScaffold({
    this.appBar,
    this.body,
    this.railElevation = RailElevation.Divider,
    this.drawerHeader,
    this.activeDrawerItemDecoration,
    this.bottomNavigationThemeData,
    this.drawerThemeData,
    @required this.currentIndex,
    @required this.destinations,
    this.onNavigationIndexChange,
    this.floatingActionButton,
  });

  @override
  _AdaptiveScaffoldState createState() => _AdaptiveScaffoldState();
}

class _AdaptiveScaffoldState extends State<AdaptiveScaffold> {
  @override
  Widget build(BuildContext context) {
    // Show a Drawer
    if (isLargeScreen(context)) {
      return Row(
        children: [
          buildDrawer(widget.destinations, isLargeDrawer: true),
          widget.railElevation != RailElevation.Backdrop
              ? VerticalDivider()
              : Container(),
          Expanded(
            child: Scaffold(
              appBar: widget.appBar,
              body: widget.body,
              floatingActionButton: widget.floatingActionButton,
              floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            ),
          ),
        ],
      );
    }

    // Show a navigation rail
    if (isMediumScreen(context)) {
      return Scaffold(
        appBar: widget.appBar,
        drawer: widget.destinations.where((d) => d.inDrawer == true).isNotEmpty
            ? buildDrawer(
                widget.destinations.where((d) => d.inDrawer == true).toList())
            : null,
        body: Row(
          children: [
            NavigationRail(
              leading: widget.floatingActionButton,
              destinations: [
                ...widget.destinations.where((d) => d.inDrawer == false).map(
                      (d) => NavigationRailDestination(
                        icon: Icon(d.icon),
                        label: Text(d.title),
                      ),
                    ),
              ],
              selectedIndex: widget.currentIndex,
              onDestinationSelected: widget.onNavigationIndexChange ?? (_) {},
            ),
            widget.railElevation != RailElevation.Backdrop
                ? VerticalDivider(
                    width: 1,
                    thickness: 1,
                    color: Colors.grey[300],
                  )
                : Container(),
            Expanded(
              child: widget.body,
            ),
          ],
        ),
      );
    }

    // Show a bottom app bar
    return Scaffold(
      body: widget.body,
      drawer: widget.destinations.where((d) => d.inDrawer == true).isNotEmpty
          ? buildDrawer(
              widget.destinations.where((d) => d.inDrawer == true).toList())
          : null,
      appBar: widget.appBar,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: widget.bottomNavigationThemeData?.backgroundColor ??
            Theme.of(context).backgroundColor,
        elevation: widget.bottomNavigationThemeData?.elevation ?? 16.0,
        selectedIconTheme:
            widget.bottomNavigationThemeData?.selectedIconTheme ??
                Theme.of(context).iconTheme,
        unselectedIconTheme:
            widget.bottomNavigationThemeData?.unselectedIconTheme ??
                Theme.of(context).iconTheme.copyWith(
                      color: Theme.of(context).unselectedWidgetColor,
                    ),
        selectedItemColor:
            widget.bottomNavigationThemeData?.selectedItemColor ??
                Theme.of(context).primaryColor,
        unselectedItemColor:
            widget.bottomNavigationThemeData?.unselectedItemColor ??
                Theme.of(context).unselectedWidgetColor,
        selectedLabelStyle:
            widget.bottomNavigationThemeData?.selectedLabelStyle ??
                Theme.of(context).textTheme.caption.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
        unselectedLabelStyle:
            widget.bottomNavigationThemeData?.unselectedLabelStyle ??
                Theme.of(context).textTheme.caption.copyWith(
                      color: Theme.of(context).unselectedWidgetColor,
                    ),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels:
            widget.bottomNavigationThemeData?.showSelectedLabels ?? true,
        showUnselectedLabels:
            widget.bottomNavigationThemeData?.showUnselectedLabels ?? true,
        /*
            BottomNavigationBarTheme.of(context)?.showSelectedLabels ??
                true, // NOTE: Little hack around the base Material to always permit hiding the selected label
                */
        //
        items: [
          ...widget.destinations.where((d) => d.inDrawer == false).map(
                (d) => BottomNavigationBarItem(
                  icon: Icon(
                    d.icon,
                  ),
                  title: Text(
                    d.title,
                  ),
                ),
              ),
        ],
        currentIndex: widget.currentIndex,
        onTap: widget.onNavigationIndexChange,
      ),
      floatingActionButton: widget.floatingActionButton,
    );
  }

  void _destinationTapped(
    AdaptiveScaffoldDestination destination, {
    @required bool needsNavigator,
  }) {
    var idx = widget.destinations.indexOf(destination);
    if (needsNavigator) {
      // NOTE: If not in a LARGE window, you can't navigate to a widget that is not available in the NavigationRail or the BottomNavigationBar
      Navigator.push(context,
          MaterialPageRoute(builder: (content) => destination.destination));
      return;
    }
    if (!isActive(idx)) {
      widget.onNavigationIndexChange(idx);
    }
  }

  bool isActive(int index) {
    return widget.currentIndex == index;
  }

  buildDrawer(
    List<AdaptiveScaffoldDestination> destinations, {
    bool isLargeDrawer = false,
  }) {
    var activeStyle = widget.activeDrawerItemDecoration;
    return Theme(
      data: widget.drawerThemeData ?? Theme.of(context),
      child: Drawer(
        child: Column(
          children: [
            widget?.drawerHeader ?? Container(),
            Expanded(
                child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  height: widget?.drawerHeader != null ? 8.0 : 0.0,
                ),
                for (var d in destinations)
                  Container(
                    decoration:
                        widget.destinations.indexOf(d) == widget.currentIndex
                            ? activeStyle
                            : BoxDecoration(),
                    child: ListTile(
                      leading: Icon(d.icon),
                      title: Text(d.title),
                      selected:
                          widget.destinations.indexOf(d) == widget.currentIndex,
                      onTap: () {
                        // Closing the drawer or else it will still be opened when we navigate back
                        if (!isLargeDrawer) {
                          Navigator.of(context).pop();
                        }
                        _destinationTapped(d, needsNavigator: !isLargeDrawer);
                      },
                    ),
                  )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
