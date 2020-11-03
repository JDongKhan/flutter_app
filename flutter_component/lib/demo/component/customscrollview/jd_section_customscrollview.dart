import 'package:flutter/material.dart';
import 'package:flutter_component/widget/sectionview/jd_sectionview.dart';

/// @author jd

class JDSectionTableView extends StatefulWidget {
  @override
  _JDSectionTableViewState createState() => _JDSectionTableViewState();
}

class _JDSectionTableViewState extends State<JDSectionTableView> {
  final List items = [];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 50; i++) {
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
      body: JDSectionView(
        header: Container(
          key: GlobalKey(),
          color: Colors.blue,
          height: 100,
        ),
        numberOfSectionInSectionView: _numberOfSectionInSectionView,
        numberOfRowsInSection: _numberOfRowsInSection,
        viewForHeaderInSection: _viewForHeaderInSection,
        viewForFooterInSection: _viewForFooterInSection,
        cellForRowAtInSection: _cellForRowAtInSection,
      ),
    );
  }

  int _numberOfSectionInSectionView() {
    return items.length;
  }

  int _numberOfRowsInSection(int section) {
    Map map = items[section];
    List array = map['items'];
    return array.length;
  }

  Widget _viewForHeaderInSection(int section) {
    Map map = items[section];
    return Container(
      color: Colors.black12,
      padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
      child: Text(map['key']),
    );
  }

  Widget _viewForFooterInSection(int section) {
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.only(left: 20),
      child: const Text('A'),
    );
  }

  Widget _cellForRowAtInSection(int section, int row) {
    Map map = items[section];
    List array = map['items'];
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
      child: Text(array[row]),
    );
  }
}
