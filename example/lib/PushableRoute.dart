import 'package:example/main.dart';
import 'package:flutter/material.dart';

class ExamplePushable extends StatelessWidget {
  final int index;
  const ExamplePushable(this.index, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLargeScreen(context)) {
      return PageBody(
        index: index,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Hello from pushed route"),
      ),
      body: PageBody(index: index),
    );
  }
}

class PageBody extends StatelessWidget {
  const PageBody({
    Key key,
    @required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("With index: $index"),
      ),
    );
  }
}
