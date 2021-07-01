import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */

class JDSearchBar extends StatefulWidget {
  JDSearchBar({this.onTap, this.text,this.color = Colors.white,this.padding = const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 0),});

  GestureTapCallback onTap;
  String text;
  final Color color;
  final EdgeInsets padding;

  @override
  State createState() => _JDSearchBarState();
}

class _JDSearchBarState extends State<JDSearchBar> {
  final TextEditingController _controller = TextEditingController();

  final FocusNode _focusNode = FocusNode(canRequestFocus: false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      alignment: Alignment.centerLeft,
      padding: widget.padding,
      child: Container(
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.all(Radius.circular(20),),
        ),
        height: 40.0,
        child: _buildSearchWidget(),
      ),
    );
  }

  Widget _buildSearchWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const SizedBox(
          width: 10.0,
        ),
        Icon(
          Icons.search,
          color: Colors.grey,
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: TextField(
//              enabled: false,
              controller: _controller,
              focusNode: _focusNode,
              decoration: InputDecoration(
                //                            contentPadding: EdgeInsets.all(0),
                hintText: widget.text ?? '查找',
                border: InputBorder.none,
              ),
              onTap: () {
                _focusNode.unfocus();
                widget?.onTap();
              },
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.cancel),
          color: Colors.grey,
          iconSize: 18.0,
          onPressed: () {
            widget.text = '';
            _controller.clear();
            setState(() {});
          },
        ),
      ],
    );
  }
}
