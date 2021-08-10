import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */

class InheritedWdgetPage extends StatefulWidget {
  final String title = "inherited_widget";

  @override
  _InheritedWdgetPageState createState() => _InheritedWdgetPageState();
}

class _InheritedWdgetPageState extends State<InheritedWdgetPage> {
  int count = 5;

  void _incrementCouter() => setState(() {
        count++;
      });

  @override
  Widget build(BuildContext context) {
    return CountContainer(
      model: this,
      increment: _incrementCouter,
      child: CounterWidget(),
    );
  }
}

class CounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CountContainer s = CountContainer.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("test"),
      ),
      body: Center(
        child: Column(children: <Widget>[Text("我马上要变化了:${s.model.count}")]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          s.increment();
        },
        tooltip: 'Route',
        child: Icon(Icons.add),
      ),
    );
  }
}

class CountContainer extends InheritedWidget {
  _InheritedWdgetPageState model;
  Function increment;

  CountContainer(
      {Key key,
      @required this.model,
      @required this.increment,
      @required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(CountContainer oldWidget) =>
      model.count != oldWidget.model.count;

  static CountContainer of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<CountContainer>();
}
