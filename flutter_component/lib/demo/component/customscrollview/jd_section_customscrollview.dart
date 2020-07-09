import 'package:flutter/material.dart';

/// @author jd

class JDSectionTableView extends StatefulWidget {
  @override
  _JDSectionTableViewState createState() => _JDSectionTableViewState();
}

class _JDSectionTableViewState extends State<JDSectionTableView> {
  final ScrollController _controller = ScrollController();

  final List items = [];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      List item = [];
      for (int j = 0; j < 10; j++) {
        item.add('$j');
      }
      items.add({
        'items': item,
        'key': '$i',
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SectionTableView'),
      ),
      body: CustomScrollView(
        controller: _controller,
        slivers: _sections(),
      ),
    );
  }

  List<Widget> _sections() {
    List<Widget> widgets = [];
    items.forEach((element) {
      //section
      Widget section = _buidlSection(element);
      widgets.add(section);
      List subItems = element['items'];
      //rows
      Widget rows = _buildRows(subItems);
      widgets.add(rows);
    });
    return widgets;
  }

  Widget _buidlSection(Map section) {
    return SliverToBoxAdapter(
      child: Container(
        height: 40,
        color: Colors.black12,
        padding: const EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Text(section['key']),
      ),
    );
  }

  Widget _buildRows(List items) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          String title = items[index];
          return Container(
            color: const Color(0xEEEEEEEE),
            padding: const EdgeInsets.all(10),
            child: Container(
              color: Colors.white,
              child: ListTile(
                title: Text(title),
              ),
            ),
          );
        },
        childCount: items.length,
      ),
    );
  }
}
