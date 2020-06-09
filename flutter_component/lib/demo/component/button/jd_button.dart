import 'package:flutter/material.dart';

class JDButtonPage extends StatefulWidget {
  @override
  State createState() => _JDButtonPageState();
}

class _JDButtonPageState extends State<JDButtonPage> with SingleTickerProviderStateMixin {
  bool _checkboxSelected=true;//维护复选框状态
  AnimationController _animationController;
  Animation<double> _iconAnimation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _iconAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0,end: 1.3).chain(CurveTween(curve: Curves.easeIn)), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.3,end: 1.0), weight: 50),
    ]).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Button'),
      ),
      body: Center(
        child: Column(
           children: <Widget>[
             RaisedButton(
               child: Text("normal"),
               onPressed: () {},
             ),

             FlatButton(
               child: Text("normal"),
               onPressed: () {},
             ),

             OutlineButton(
               child: Text("normal"),
               onPressed: () {},
             ),

             IconButton(
               icon: Icon(Icons.thumb_up),
               onPressed: () {},
             ),

             RaisedButton.icon(
               icon: Icon(Icons.send),
               label: Text("发送"),
               onPressed: (){},
             ),

             OutlineButton.icon(
               icon: Icon(Icons.add),
               label: Text("添加"),
               onPressed: (){},
             ),

             FlatButton.icon(
               icon: Icon(Icons.info),
               label: Text("详情"),
               onPressed: (){},
             ),

             FlatButton(
               color: Colors.blue,
               highlightColor: Colors.blue[700],
               colorBrightness: Brightness.dark,
               splashColor: Colors.grey,
               child: Text("Submit"),
               shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
               onPressed: () {},
             ),

             RaisedButton(
               color: Colors.blue,
               highlightColor: Colors.blue[700],
               colorBrightness: Brightness.dark,
               splashColor: Colors.grey,
               child: Text("Submit"),
               shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
               onPressed: () {},
             ),
             ScaleTransition(
               scale: _iconAnimation,
               child: _checkboxSelected
                   ? IconButton(padding: EdgeInsets.all(10),icon: const Icon(Icons.brightness_3),onPressed: () {
                      _clickIcon();
                    })
                   : IconButton(padding: EdgeInsets.all(10),icon: const Icon(Icons.brightness_1),onPressed: () {
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

