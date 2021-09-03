import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

/// @author jd

class ScrollToIndexDemoPage extends StatelessWidget {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ScrollToIndexDemoPage'),
      ),
      body: ScrollablePositionedList.builder(
        itemCount: 100,
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        itemBuilder: (context, index) {
          print('layout: $index');
          return Container(
            height: index * 10.0 + 100.0,
            child: Center(child: Text('$index')),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int index = Random().nextInt(100);
          print('Scroll to $index');
          itemScrollController.scrollTo(
            index: index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
          );
        },
        tooltip: 'Scroll',
        child: Icon(Icons.scatter_plot),
      ),
    );
  }
}
