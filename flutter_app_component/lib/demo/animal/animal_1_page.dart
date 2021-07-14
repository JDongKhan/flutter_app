import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// @author jd

class Animal1Page extends StatefulWidget {
  @override
  _Animal1PageState createState() => _Animal1PageState();
}

class _Animal1PageState extends State<Animal1Page> {
  IconData iconData = Icons.clear;

  ///定义需要执行的滑动效果数值
  double _width = 50;
  double _height = 50;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimationContainerDemoPage Demo'),
      ),
      body: Center(
        child: AnimatedContainer(
          // Use the properties stored in the State class.
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            color: _color,
            borderRadius: _borderRadius,
          ),
          // Define how long the animation should take.
          duration: Duration(seconds: 1),
          // Provide an optional curve to make the animation feel smoother.
          curve: Curves.fastOutSlowIn,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: AnimatedSwitcher(
          transitionBuilder: (child, anim) {
            return ScaleTransition(child: child, scale: anim);
          },
          duration: Duration(milliseconds: 300),
          child: IconButton(
              key: ValueKey(iconData),
              icon: Icon(iconData),
              onPressed: () {
                setState(() {
                  if (iconData == Icons.clear)
                    iconData = Icons.add;
                  else
                    iconData = Icons.clear;
                });
              }),
        ),
        // When the user taps the button
        onPressed: () {
          if (iconData == Icons.clear)
            iconData = Icons.add;
          else
            iconData = Icons.clear;

          // Use setState to rebuild the widget with new values.
          setState(() {
            // Create a random number generator.
            final random = math.Random();

            // Generate a random width and height.
            _width = random.nextInt(300).toDouble();
            _height = random.nextInt(300).toDouble();

            // Generate a random color.
            _color = Color.fromRGBO(
              random.nextInt(256),
              random.nextInt(256),
              random.nextInt(256),
              1,
            );

            // Generate a random border radius.
            _borderRadius =
                BorderRadius.circular(random.nextInt(100).toDouble());
          });
        },
      ),
    );
  }
}
