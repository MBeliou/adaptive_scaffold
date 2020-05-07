# adaptive_scaffold

> :warning: This package **REQUIRES** a flutter version >= 1.17 since it depends on Material's NavigationRail.

The adaptive_scaffold allows you to easily create a themable responsive scaffold.


## Getting Started

### 1 - Add to pubspec.yaml
```yml
dependencies:
  adaptive_scaffold: ^0.2.0
```

### 2 - Update dependencies
```sh
$ flutter packages get
```

### 3 - Use it
```dart
import "packages:adaptive_scaffold/AdaptiveScaffold.dart";
import 'package:flutter/material.dart';


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }
  
  // Creating the routing destinations. In this example, all with and index > 3 will be set in the drawer and will be using the Navigator to handle routing when the screen size is small or medium. Hence requiring an adaptive widget.
  List<AdaptiveScaffoldDestination> destinations = List.generate(
    5,
    (index) => AdaptiveScaffoldDestination(
      title: "Title $index",
      icon: Icons.ac_unit,
      destination: index > 3
          ? AdaptivePushableWidget(index)
          : Container(
              child: Center(
                child: Text("this is $index"),
              ),
            ),
      inDrawer: index > 3,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: myTheme,
      home: AdaptiveScaffold(
        appBar: AppBar(
          title: Text("AdaptiveScaffold title"),
        ),
        currentIndex: currentIndex,
        drawerThemeData: Theme.of(context).copyWith(
          canvasColor: Colors.amber.shade300, // Change the background color of the drawer
        ),
        // Give a custom drawer header
        drawerHeader: MyDrawerHeader(),
        railElevation: RailElevation.Backdrop,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => print("Look, I pressed the FAB!"),
        ),
        destinations: destinations,
        // Add a decoration to the drawer listiles
        activeDrawerItemDecoration: BoxDecoration(
          border: Border(
            right: BorderSide(width: 3.0, color: Colors.red.shade500),
          ),
        ),
        onNavigationIndexChange: (index) {
          setState(() => currentIndex = index);
        },
        body: Container(
          color: Colors.grey.shade200,
          child:
              Center(child: destinations.elementAt(currentIndex).destination),
        ),
      ),
    );
  }
}

class MyDrawerHeader extends DrawerHeader {
  MyDrawerHeader({Key key});

  @override
  DrawerHeader build(BuildContext context) {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Adaptive Scaffold",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
            Text(
              "In a package",
              style: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 16,
              ),
            ),
          ],
        ));
  }
}
```

## Example & Theming
An example including Theming is available in the example folder.

