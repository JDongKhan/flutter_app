import 'package:flutter/material.dart';

class TextPage extends StatefulWidget {
  TextPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the demo.funcation.state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  String title;

  @override
  State createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  int _counter = 0;

  String textContent =
      "Today I was amazed to see the usually positive and friendly VueJS community descend into a bitter war. Two weeks ago Vue creator Evan You released a Request for Comment (RFC) for a new function-based way of writing Vue components in the upcoming Vue 3.0. Today a critical "
      "Reddit thread followed by similarly "
      "critical comments in a Hacker News thread caused a "
      "flood of developers to flock to the original RFC to "
      "voice their outrage, some of which were borderline abusive. "
      "It was claimed in various places that";

  final double leading = 0.9;

  final double fontSize = 16;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    debugPrint("initState");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build");
    // 在Widget树中向上查找最近的父级`Scaffold` widget
    // Scaffold scaffold = context.ancestorWidgetOfExactType(Scaffold);

    //获取路由参数

    if (widget.title == null) {
      var args = ModalRoute.of(context).settings.arguments;
      Map map = args as Map;
      if (map != null) {
        widget.title = map["title"] as String;
      } else {
        widget.title = "Default Text Page";
      }
    }
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SingleChildScrollView(
          child: Column(
            // Column is also layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Hello world " * 10, //字符串重复六次
                textAlign: TextAlign.center,
              ),

              Text(
                "I'm Jack. " * 14,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              //MediaQueryData.textScaleFactor
              Text(
                "Hello world",
                textScaleFactor: 1.5,
              ),

              Text("Hello world",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18.0,
                      height: 1.2,
                      fontFamily: "Courier",
                      background: new Paint()..color = Colors.yellow,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.dashed)),

              Text.rich(TextSpan(children: [
                WidgetSpan(
                  child: Icon(Icons.people),
                ),
                TextSpan(text: "Home: "),
                TextSpan(
                  text: "https://flutterchina.club",
                  style: TextStyle(color: Colors.blue),
//                      recognizer: _tapRecognizer
                ),
              ])),

              DefaultTextStyle(
                //1.设置文本默认样式
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.start,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("hello world"),
                    Text("I am Jack"),
                    Text(
                      "I am Jack",
                      style: TextStyle(
                          inherit: false, //2.不继承默认样式
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),

              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.display1,
              ),

              Container(
                color: Colors.blueGrey,
                margin: EdgeInsets.all(20),

                ///利用 Transform 偏移将对应权重部分位置
                child: Transform.translate(
                  offset: Offset(0, -fontSize * leading / 2),
                  child: new Text(
                    textContent,
                    strutStyle: StrutStyle(
                        forceStrutHeight: true, height: 1, leading: leading),
                    style: TextStyle(
                      fontSize: fontSize,
                      color: Colors.black,
                      //backgroundColor: Colors.greenAccent),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  /***************** 重写一些方法 *******************/

  @override
  void didUpdateWidget(TextPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint("didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    debugPrint("deactive");
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("dispose");
  }

  @override
  void reassemble() {
    super.reassemble();
    debugPrint("reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("didChangeDependencies");
  }
}
