import 'package:flutter/material.dart';

/// @author jd

class JDDropdownButton<T> extends StatelessWidget {
  JDDropdownButton({
    Key key,
    @required this.items,
    this.value,
    this.style,
    this.onChanged,
    this.dropdownColor,
  }) : super(key: key);

  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T> onChanged;
  final TextStyle style;
  final T value;
  final Color dropdownColor;

  var _currentValue = '';
  get currentValue => _currentValue;
  set currentValue(v) {
    _currentValue = v;
    if (this.onChanged != null) {
      this.onChanged(v);
    }
  }

  OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  void _click(BuildContext context) {
    if (_overlayEntry != null) {
      _dismiss();
    } else {
      _show(context);
    }
  }

  void _show(BuildContext context) {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height),
          child: Material(
            color: dropdownColor ?? Colors.white,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue[100]),
              ),
              child: Column(
                children: items
                    .map(
                      (e) => ListTile(
                        title: e.child,
                        onTap: () {
                          _dismiss();
                          currentValue = e.value;
                          if (e.onTap != null) {
                            e.onTap();
                          }
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry);
  }

  void _dismiss() {
    _overlayEntry.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) =>
            GestureDetector(
          onTap: () {
            _click(context);
            setState(() {});
          },
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  '${_currentValue.length > 0 ? _currentValue : value}',
                  textAlign: TextAlign.left,
                  style: style,
                ),
              ),
              ExpandIcon(
                isExpanded: _overlayEntry != null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
