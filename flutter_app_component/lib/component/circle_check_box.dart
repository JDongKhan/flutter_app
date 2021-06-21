import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// @author jd

class CircleCheckBox extends StatelessWidget {
  CircleCheckBox({
    Key key,
    this.value = false,
    this.unCheckColor = Colors.grey,
    this.checkColor = Colors.blue,
    @required this.onChanged,
  }) : super(key: key);
  final bool value;
  final Color unCheckColor;
  final Color checkColor;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (onChanged != null) {
          onChanged(!value);
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: value
            ? Icon(
                Icons.check_circle,
                color: checkColor,
              )
            : Icon(
                Icons.radio_button_unchecked_outlined,
                color: unCheckColor,
              ),
      ),
    );
  }
}
