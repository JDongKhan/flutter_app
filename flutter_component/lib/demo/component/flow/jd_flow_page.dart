import 'package:flutter/material.dart';

/// @author jd

class JDFlowPage extends StatefulWidget {
  @override
  _JDFlowPageState createState() => _JDFlowPageState();
}

class _JDFlowPageState extends State<JDFlowPage>
    with SingleTickerProviderStateMixin {
  AnimationController _ctrlAnimationPopMenu;
  IconData lastTapped = Icons.notifications;

  final List<IconData> menuItems = <IconData>[
    Icons.home,
    Icons.new_releases,
    Icons.notifications,
    Icons.settings,
    Icons.menu
  ];

  void _updateMenu(IconData icon) {
    if (icon != Icons.menu) {
      setState(() {
        lastTapped = icon;
      });
    } else {
      _ctrlAnimationPopMenu.status == AnimationStatus.completed
          ? _ctrlAnimationPopMenu.reverse()
          : _ctrlAnimationPopMenu.forward();
    }
  }

  @override
  void initState() {
    super.initState();
    _ctrlAnimationPopMenu = AnimationController(
        duration: const Duration(milliseconds: 250), value: 0);
  }

  Widget _flowMenuItem(IconData icon) {
    final double buttonDiameter =
        MediaQuery.of(context).size.width * 2 / (menuItems.length * 3);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RawMaterialButton(
        fillColor: lastTapped == icon ? Colors.amber[700] : Colors.blue,
        splashColor: Colors.amber[100],
        shape: CircleBorder(),
        constraints: BoxConstraints.tight(Size(buttonDiameter, buttonDiameter)),
        onPressed: () {
          _updateMenu(icon);
        },
        child: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flow'),
      ),
      body: Center(
        child: Flow(
          delegate: FlowMenuDelegate(_ctrlAnimationPopMenu),
          children: menuItems.map((e) => _flowMenuItem(e)).toList(),
        ),
      ),
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  FlowMenuDelegate(this.animation);

  final Animation<double> animation;

  @override
  void paintChildren(FlowPaintingContext context) {
    double x = 50.0;
    final double y = 50.0;
    for (int i = 0; i < context.childCount; i++) {
      x = context.getChildSize(i).width * i * animation.value;
      context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
    }
  }

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) =>
      animation != oldDelegate.animation;
}
