/// @author jd
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef OnTapCallback = void Function(String key);

//隐私弹框
class PrivacyWidget extends StatefulWidget {
  final String data;
  final List<String> keys;
  final TextStyle style;
  final TextStyle keyStyle;
  final OnTapCallback onTapCallback;

  const PrivacyWidget({
    Key key,
    @required this.data,
    @required this.keys,
    this.style,
    this.keyStyle,
    this.onTapCallback,
  }) : super(key: key);

  @override
  _PrivacyViewState createState() => _PrivacyViewState();
}

class _PrivacyViewState extends State<PrivacyWidget> {
  List<String> _list = [];

  @override
  void initState() {
    _split();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <InlineSpan>[
            ..._list.map((e) {
              if (widget.keys.contains(e)) {
                return TextSpan(
                  text: '$e',
                  style: widget.keyStyle ??
                      TextStyle(color: Theme.of(context).primaryColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      widget.onTapCallback?.call(e);
                    },
                );
              } else {
                return TextSpan(text: '$e', style: widget.style);
              }
            }).toList()
          ]),
    );
  }

  void _split() {
    int startIndex = 0;
    Map<String, dynamic> _index;
    while ((_index = _nextIndex(startIndex)) != null) {
      int i = _index['index'];
      String sub = widget.data.substring(startIndex, i);
      if (sub.isNotEmpty) {
        _list.add(sub);
      }
      _list.add(_index['key']);

      startIndex = i + (_index['key'] as String).length;
    }
  }

  Map<String, dynamic> _nextIndex(int startIndex) {
    int currentIndex = widget.data.length;
    String key;
    widget.keys.forEach((element) {
      int index = widget.data.indexOf(element, startIndex);
      if (index != -1 && index < currentIndex) {
        currentIndex = index;
        key = element;
      }
    });
    if (key == null) {
      return null;
    }
    return {'key': '$key', 'index': currentIndex};
  }
}
