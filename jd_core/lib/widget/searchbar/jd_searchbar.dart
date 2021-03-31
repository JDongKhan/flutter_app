import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */

class JDSearchBar extends StatefulWidget {
  JDSearchBar({this.onTap, this.text});

  GestureTapCallback onTap;
  String text;

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
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Card(
          child: _buildSearchWidget(),
        ),
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
                widget.onTap();
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
