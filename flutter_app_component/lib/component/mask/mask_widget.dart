import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// @author jd

class MarkEntry {
  const MarkEntry({
    this.widget,
    this.top,
    this.left,
  });

  final Widget widget;
  final double top;
  final double left;
}

class MarkWidget extends StatelessWidget {
  const MarkWidget({
    this.child,
    this.entryList,
  });
  final Widget child;
  final List<MarkEntry> entryList;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        _MarkWidget(
          entryList: entryList,
        ),
      ],
    );
  }
}

class _MarkWidget extends StatefulWidget {
  const _MarkWidget({
    this.entryList,
  });
  final List<MarkEntry> entryList;
  @override
  _MarkWidgetState createState() => _MarkWidgetState();
}

class _MarkWidgetState extends State<_MarkWidget> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    if (currentIndex > widget.entryList.length - 1) {
      currentIndex = widget.entryList.length;
      return const SizedBox.shrink();
    }
    final MarkEntry entry = widget.entryList[currentIndex];
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex++;
        });
      },
      child: Container(
        color: Colors.black.withOpacity(
          0.4,
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: entry.left,
              top: entry.top,
              child: Material(
                color: Colors.transparent,
                child: entry.widget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
