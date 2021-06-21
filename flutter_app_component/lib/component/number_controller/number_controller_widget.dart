import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// @author jd

class NumberControllerWidget extends StatefulWidget {
  const NumberControllerWidget({
    Key key,
    this.height = 30,
    this.width = 40,
    this.iconWidth = 40,
    this.defultNum = 0,
    this.min = 0,
    this.max = 99999,
    this.updateChanged,
  }) : super(key: key);
  final int max;
  final int min;
  final double height;
  final double width;
  final double iconWidth;
  final int defultNum;
  final ValueChanged updateChanged;

  @override
  _NumberControllerWidgetState createState() => _NumberControllerWidgetState();
}

class _NumberControllerWidgetState extends State<NumberControllerWidget> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.defultNum.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CoustomIconButton(icon: Icons.remove),
          Container(
            width: widget.width,
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(width: 1, color: Colors.black12),
                right: BorderSide(width: 1, color: Colors.black12),
              ),
            ),
            child: TextField(
              inputFormatters: [
                FilteringTextInputFormatter(RegExp('[0-9]'), allow: true),
              ],
              controller: _textEditingController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
              ),
              enableInteractiveSelection: false,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.only(left: 0, top: 2, bottom: 2, right: 0),
                border: OutlineInputBorder(
                  gapPadding: 0,
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
          ),
          CoustomIconButton(icon: Icons.add, isAdd: true),
        ],
      ),
    );
  }

  Widget CoustomIconButton({IconData icon, bool isAdd = false}) {
    return Container(
      width: widget.width,
      alignment: Alignment.center,
      child: IconButton(
        iconSize: 20,
        padding: const EdgeInsets.all(0.0),
        icon: Icon(icon),
        onPressed: () {
          var num = int.parse(_textEditingController.text);
          if (isAdd) {
            num++;
          } else {
            num--;
          }
          _textEditingController.text = num.toString();
          if (widget.updateChanged != null) {
            widget.updateChanged(num);
          }
        },
      ),
    );
  }
}
