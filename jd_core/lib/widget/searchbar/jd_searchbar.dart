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
    this.hintText,
    this.height = 40,
    this.color = Colors.white,
    this.padding =
        const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 0),
  });

  final ValueChanged<String> onSubmitted;
  GestureTapCallback onTap;
  String text;
  String hintText;
  final Color color;
  final double height;
  final EdgeInsets padding;

  @override
  State createState() => _JDSearchBarState();
}

class _JDSearchBarState extends State<JDSearchBar> {
  final TextEditingController _controller = TextEditingController();

  final FocusNode _focusNode = FocusNode(canRequestFocus: false);
  bool _editIconShow = false;
  @override
  void initState() {
    _controller.text = widget.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      alignment: Alignment.centerLeft,
      padding: widget.padding,
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.all(
            Radius.circular((widget.height) / 2),
          ),
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
      style: TextStyle(
        fontSize: 14,
      ),
      maxLines: 1,
      onChanged: (text) {
        if (text.length > 0) {
          if (_editIconShow == false) {
            setState(() {
              _editIconShow = true;
            });
          }
        } else {
          setState(() {
            _editIconShow = false;
          });
        }
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
          top: 8,
          bottom: 8,
        ),
        hintText: widget.hintText ?? '查找',
        filled: true,
        // isDense: true,
        fillColor: Colors.transparent,
        border: InputBorder.none,
        isCollapsed: true, //相当于高度包裹的意思，必须为true，不然有默认的最小高度
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey,
        ),
        suffixIcon: _editIconShow
            ? GestureDetector(
                child: Icon(
                  Icons.cancel,
                  color: Colors.grey[600],
                  size: 18,
                ),
                onTap: () {
                  widget.text = '';
                  _controller.clear();
                  setState(() {
                    _editIconShow = false;
                  });
                },
              )
            : null,
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
