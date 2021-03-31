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
  List<String> _colors = [
    '红色',
    '白色',
    '蓝色',
  ];
  String _color;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 300), value: 0, vsync: this);
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
        child: ListView(
          children: <Widget>[
            BackButton(
              color: Colors.black,
              onPressed: () {},
            ),
            CloseButton(
              color: Colors.black,
              onPressed: () {},
            ),
            OutlinedButton(
              child: const Text('OutlinedButton'),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.thumb_up),
              onPressed: () {},
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.send),
              label: const Text('ElevatedButton'),
              onPressed: () {},
            ),
            OutlinedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('OutlinedButton'),
              onPressed: () {},
            ),
            TextButton.icon(
              icon: const Icon(Icons.info),
              label: const Text('TextIconButton'),
              onPressed: () {},
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
              child: const Text('TextButton'),
              onPressed: () {},
            ),
            ElevatedButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
              child: const Text('ElevatedButton'),
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
            ),
            RawMaterialButton(
              onPressed: () {},
              child: const Text('RawMaterialButton'),
            ),
            _buildDropdownButton(),
            _buildToggleButton(),
            _buildPopupButton(),
            _buildButtonBar(),
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

  Widget _buildDropdownButton() {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(
        bottom: 20,
        top: 20,
      ),
      child: DropdownButton<String>(
        value: _color,
        isDense: true,
        isExpanded: true,
        hint: const Text('请选择'),
        onChanged: (String newValue) {
          setState(() {
            _color = newValue;
          });
        },
        items: _colors
            .map(
              (e) => DropdownMenuItem<String>(
                child: Text(e),
                value: e,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildPopupButton() {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(
        bottom: 20,
        top: 20,
      ),
      child: PopupMenuButton<String>(
        itemBuilder: (BuildContext context) {
          return _colors
              .map((e) => PopupMenuItem<String>(
                    child: Text(e),
                    value: e,
                  ))
              .toList();
        },
      ),
    );
  }

  Widget _buildButtonBar() {
    return Container(
      width: 150,
      color: Colors.red,
      margin: const EdgeInsets.only(
        bottom: 20,
        top: 20,
      ),
      child: ButtonBar(
        alignment: MainAxisAlignment.start,
        children: _colors
            .map(
              (e) => TextButton(
                onPressed: () {},
                child: Text(e),
              ),
            )
            .toList(),
      ),
    );
  }

  List<bool> isSelected = [true, false, false];

  Widget _buildToggleButton() {
    return ToggleButtons(
      children: const <Widget>[
        Icon(Icons.ac_unit),
        Icon(Icons.call),
        Icon(Icons.cake),
      ],
      onPressed: (int index) {
        setState(() {
          for (int buttonIndex = 0;
              buttonIndex < isSelected.length;
              buttonIndex++) {
            if (buttonIndex == index) {
              isSelected[buttonIndex] = true;
            } else {
              isSelected[buttonIndex] = false;
            }
          }
        });
      },
      isSelected: isSelected,
    );
  }
}
