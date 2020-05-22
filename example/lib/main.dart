import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:preload_page_view/preload_page_view.dart';

import 'page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PreloadPageView Demo',
      home: PreloadPageViewDemo(),
    );
  }
}

class PreloadPageViewDemo extends StatefulWidget {
  PreloadPageViewDemo({Key key}) : super(key: key);

  @override
  _PreloadPageViewState createState() => _PreloadPageViewState();
}

class _PreloadPageViewState extends State<PreloadPageViewDemo> {
  int _preloadCount = 5;
  set preloadCount(int x) => setState(() => _preloadCount = x);
  int get preloadCount => _preloadCount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PreloadPageView Demo"),
      ),
      body: Column(
        children: [
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.remove,
                  ),
                  onPressed: preloadCount <= 0 ? null : () => preloadCount -= 1,
                ),
                FlatButton(
                    child: Text("Preload Cache Count: $preloadCount"),
                    onPressed: () => preloadCount = preloadCount),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.add,
                      ),
                      onPressed: () => preloadCount += 1,
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: PreloadPageView.builder(
              preloadPagesCount: preloadCount,
              itemBuilder: (BuildContext context, int position) =>
                  DemoPage(position),
              controller: PreloadPageController(initialPage: 1),
              onPageChanged: (position) =>
                  log('page changed. current: $position'),
            ),
          ),
          RaisedButton(
              child: Text("Clear Log"), onPressed: () => _log.value = ''),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: ValueListenableBuilder(
                  valueListenable: _log,
                  builder: (c, d, _) => Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey,
                      padding: const EdgeInsets.all(10),
                      child: Text(d,
                          style: TextStyle(
                              height: 1.2, fontFamily: 'Courier New')))),
            ),
          )),
        ],
      ),
    );
  }
}

final _log = ValueNotifier('');

final _controller = () {
  final controller = StreamController<String>();
  controller.stream.listen((s) => _log.value = s + "\n" + _log.value);
  return controller;
}();
final log = _controller.add;
