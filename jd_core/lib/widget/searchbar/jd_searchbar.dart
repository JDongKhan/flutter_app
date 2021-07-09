import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */

class JDSearchBar extends StatefulWidget {
  JDSearchBar({
    this.onTap,
    this.onSubmitted,
    this.text,
    this.height = 40,
    this.color = Colors.white,
    this.padding = const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 0),
  });

  final ValueChanged<String> onSubmitted;
  GestureTapCallback onTap;
  String text;
  final Color color;
  final double height;
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
      height: widget.height,
      alignment: Alignment.centerLeft,
      padding: widget.padding,
      child: Container(
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.all(Radius.circular((widget.height)/2),),
        ),
        height: widget.height,
        child: _buildSearchWidget(),
      ),
    );
  }

  Widget _buildSearchWidget() {
    return TextField(
//              enabled: false,
      controller: _controller,
      focusNode: _focusNode,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 0,bottom: 0),
        hintText: widget.text ?? '查找',
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey,
        ),
        suffixIcon:  GestureDetector(
          child: Icon(Icons.cancel, color: Colors.grey[600],size: 18,),
          onTap: () {
          widget.text = '';
          _controller.clear();
          setState(() {});
        },),
        border: InputBorder.none,
      ),
      onSubmitted: (String value) {
        if (widget.onSubmitted != null) {
          widget.onSubmitted(value);
        }
      },
      onTap: () {
        if (widget.onTap != null) {
          _focusNode.unfocus();
          widget.onTap();
        }
      },
    );
  }
}
