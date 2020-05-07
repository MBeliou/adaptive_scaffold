import 'package:example/PushableRoute.dart';
import 'package:example/theme.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_scaffold/adaptive_scaffold.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
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

  List<AdaptiveScaffoldDestination> destinations = List.generate(
    5,
    (index) => AdaptiveScaffoldDestination(
      title: "Title $index",
      icon: Icons.ac_unit,
      destination: index > 3
          ? ExamplePushable(index)
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
        drawerHeader: MyDrawerHeader(),
        railElevation: RailElevation.Backdrop,
        //drawerThemeData: ThemeData(),

        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => print("I pressed the Button"),
        ),
        destinations: destinations,
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
