import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// @author jd

OverlayEntry overlayEntry;

class MarkEntry {
  final Widget widget;
  final double top;
  final double left;
  const MarkEntry({
    this.widget,
    this.top,
    this.left,
  });
}

class MarkWidget extends StatefulWidget {
  final List<MarkEntry> entrys;
  const MarkWidget({this.entrys});

  @override
  _MarkWidgetState createState() => _MarkWidgetState();
}

class _MarkWidgetState extends State<MarkWidget> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    MarkEntry entry = widget.entrys[currentIndex];
    return GestureDetector(
      onTap: () {
        if (currentIndex >= (widget.entrys.length - 1)) {
          overlayEntry?.remove();
          overlayEntry = null;
          return;
        }
        setState(() {
          currentIndex++;
        });
      },
      child: Container(
        color: Colors.black.withOpacity(
          0.4,
        ),
        child: Stack(
          children: [
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

class MarkUtils {
  static void showMark(BuildContext context, List<MarkEntry> entrys) {
    overlayEntry = OverlayEntry(
      builder: (context) {
        return MarkWidget(
          entrys: entrys,
        );
      },
    );
    Overlay.of(context).insert(overlayEntry);
  }
}
