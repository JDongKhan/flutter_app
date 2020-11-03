import 'package:flutter/material.dart';

class JDButtonPage extends StatefulWidget {
  @override
  State createState() => _JDButtonPageState();
}

class _JDButtonPageState extends State<JDButtonPage>
    with SingleTickerProviderStateMixin {
  bool _checkboxSelected = true; //维护复选框状态
  AnimationController _animationController;
  Animation<double> _iconAnimation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 300), value: 0);
    _iconAnimation = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 1.3)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 50),
    ]).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: const Text('normal'),
              onPressed: () {},
            ),
            FlatButton(
              child: const Text('normal'),
              onPressed: () {},
            ),
            OutlineButton(
              child: const Text('normal'),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.thumb_up),
              onPressed: () {},
            ),
            RaisedButton.icon(
              icon: const Icon(Icons.send),
              label: const Text('发送'),
              onPressed: () {},
            ),
            OutlineButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('添加'),
              onPressed: () {},
            ),
            FlatButton.icon(
              icon: const Icon(Icons.info),
              label: const Text('详情'),
              onPressed: () {},
            ),
            FlatButton(
              color: Colors.blue,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              child: const Text('Submit'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {},
            ),
            RaisedButton(
              color: Colors.blue,
              highlightColor: Colors.blue[700],
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              child: const Text('Submit'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {},
            ),
            ScaleTransition(
              scale: _iconAnimation,
              child: _checkboxSelected
                  ? IconButton(
                      padding: const EdgeInsets.all(10),
                      icon: const Icon(Icons.brightness_3),
                      onPressed: () {
                        _clickIcon();
                      })
                  : IconButton(
                      padding: const EdgeInsets.all(10),
                      icon: const Icon(Icons.brightness_1),
                      onPressed: () {
                        _clickIcon();
                      }),
            )
          ],
        ),
      ),
    );
  }

  void _clickIcon() {
    setState(() {
      _checkboxSelected = !_checkboxSelected;
    });
  }
}
