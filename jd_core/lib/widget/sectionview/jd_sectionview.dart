import 'package:flutter/material.dart';

/// @author jd

typedef NumberOfSectionInSectionView = int Function();

typedef NumberOfRowsInSection = int Function(int section);

typedef ViewForHeaderInSection = Widget Function(int section);

typedef ViewForFooterInSection = Widget Function(int section);

typedef CellForRowAtInSection = Widget Function(int section, int row);

class JDSectionView extends StatefulWidget {
  const JDSectionView({
    Key key,
    this.controller,
    this.numberOfSectionInSectionView,
    this.numberOfRowsInSection,
    this.viewForHeaderInSection,
    this.viewForFooterInSection,
    this.cellForRowAtInSection,
    this.separated = true,
    this.header,
    this.footer,
  }) : super(key: key);

  final ScrollController controller;

  final NumberOfSectionInSectionView numberOfSectionInSectionView;
  final NumberOfRowsInSection numberOfRowsInSection;
  final ViewForHeaderInSection viewForHeaderInSection;
  final ViewForFooterInSection viewForFooterInSection;
  final CellForRowAtInSection cellForRowAtInSection;
  final bool separated;
  final Widget header;
  final Widget footer;

  @override
  _JDSectionViewState createState() => _JDSectionViewState();
}

class _JDSectionViewState extends State<JDSectionView> {
  ScrollController _controller;
  Widget _suspensionWidget;
  double _suspensionTop = 0;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ScrollController();
    _controller.addListener(() {
      final int offset = _controller.offset.toInt();
      _handleOffset(offset);
    });
  }

  void _handleOffset(int offset) {
    if (widget.header != null) {
      final Key headerKey = widget.header.key;
      assert(headerKey != null, 'header 必须要指定个key');
      final double headerHeight =
          (headerKey as GlobalKey).currentContext.size.height;
      print('headerHeight: $headerHeight');
      if (offset < headerHeight) {
        _suspensionWidget = null;
        setState(() {
          _suspensionTop = -headerHeight;
        });
        return;
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[
      CustomScrollView(
        controller: _controller,
        slivers: _sections(),
      ),
    ];
    if (_suspensionWidget != null) {
      children.add(Positioned(
        top: _suspensionTop,
        left: 0.0,
        right: 0.0,
        child: _suspensionWidget,
      ));
    }
    return Stack(children: children);
  }

  List<Widget> _sections() {
    final List<Widget> widgets = [];
    //header view
    if (widget.header != null) {
      widgets.add(SliverToBoxAdapter(
        child: widget.header,
      ));
    }

    final int sections = widget.numberOfSectionInSectionView();
    for (int section = 0; section < sections; section++) {
      //header section
      final Widget headerWidget = _buildHeaderSection(section);
      if (headerWidget != null) {
        widgets.add(headerWidget);
      }

      //rows
      final Widget rows = _buildRows(section);
      widgets.add(rows);

      //footer section
      final Widget footerWidget = _buildFooterSection(section);
      if (footerWidget != null) {
        widgets.add(footerWidget);
      }
    }

    //footer view
    if (widget.footer != null) {
      widgets.add(SliverToBoxAdapter(
        child: widget.footer,
      ));
    }

    return widgets;
  }

  Widget _buildHeaderSection(int section) {
    if (widget.viewForHeaderInSection == null) {
      return null;
    }
    final Widget sectionWidget = widget.viewForHeaderInSection(section);
    return SliverToBoxAdapter(
      child: sectionWidget,
    );
  }

  Widget _buildFooterSection(int section) {
    if (widget.viewForFooterInSection == null) {
      return null;
    }
    final Widget footerWidget = widget.viewForFooterInSection(section);
    return SliverToBoxAdapter(
      child: footerWidget,
    );
  }

  Widget _buildRows(int section) {
    final int count = widget.numberOfRowsInSection(section);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final Widget row = widget.cellForRowAtInSection(section, index);
          if (widget.separated) {
            Column c = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                row,
                const Divider(
                  height: 1,
                ),
              ],
            );
            return c;
          }
          return row;
        },
        childCount: count,
      ),
    );
  }
}
