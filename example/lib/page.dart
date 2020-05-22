import 'package:flutter/material.dart';

import 'main.dart';

class DemoPage extends StatelessWidget {
  DemoPage(this.index);
  final int index;

  @override
  Widget build(BuildContext context) {
    log('Page loaded: $index');

    return Center(
      child: Text(
        'Page $index',
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}
