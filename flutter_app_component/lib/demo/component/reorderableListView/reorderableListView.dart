import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jd_core/utils/jd_screen_utils.dart';

class JDReorderableListView extends StatefulWidget {
  @override
  _JDReorderableListViewState createState() => _JDReorderableListViewState();
}

class _JDReorderableListViewState extends State<JDReorderableListView> {
  final datas = [
    Colors.yellow[50],
    Colors.blue[100],
    Colors.red[200],
    Colors.pink[300],
  ];

  final dataList = [
    {
      'icon': Icons.map,
      'title': '关注',
      'move': false,
    },
    {
      'icon': Icons.map,
      'title': '推荐',
      'move': false,
    },
    {
      'icon': Icons.map,
      'title': '视频',
      'move': false,
    },
    {
      'icon': Icons.map,
      'title': '热榜',
      'move': false,
    },
    {
      'icon': Icons.map,
      'title': '资讯',
      'move': false,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReorderableListView'),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            child: ReorderableListView(
              padding: const EdgeInsets.all(10),
              onReorder: _handleReorder,
              scrollDirection: Axis.vertical,
              children: datas.map((e) => _buildItem(e)).toList(),
            ),
          ),
          Container(
            height: 300,
            color: Colors.black12,
            child: _buildLongGrindView(),
          )
        ],
      ),
    );
  }

  void _handleReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    setState(() {
      final element = datas.removeAt(oldIndex);
      datas.insert(newIndex, element);
    });
  }

  Widget _buildItem(Color color) {
    return Container(
      key: ValueKey(color),
      alignment: Alignment.center,
      height: 50,
      width: 200,
      color: color,
    );
  }

  Widget renderItem(index) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          alignment: Alignment.center,
          child: Text(dataList[index]['title']),
        ),
        Positioned(
          child: Text(dataList[index]['move'] == false ? 'x' : '+'),
          right: 10,
          top: 2,
        ),
      ],
    );
  }

  Widget _buldItemWidget(int index) {
    return LongPressDraggable(
      data: index,
      child: DragTarget<int>(
        onAccept: (data) {
          // widget.on
        },
        builder: (BuildContext context, data, rejects) {
          return renderItem(index);
        },
        onMove: (data) {
          debugPrint(data.toString());
        },
        onLeave: (data) {
          debugPrint('$data is Leaving item $index');
        },
        onWillAccept: (data) {
          return true;
        },
      ),
      onDragStarted: () {},
      onDraggableCanceled: (Velocity velocity, Offset offset) {},
      onDragCompleted: () {},
      feedback: Material(
        child: Container(
          width: (jd_screenWidth() - 40) / 3,
          height: (jd_screenWidth() - 40) / 3 * 4 / 10,
          child: renderItem(index),
        ),
      ),
      childWhenDragging: Container(),
    );
  }

  Widget _buildLongGrindView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: dataList.length,
      itemBuilder: (BuildContext context, int index) {
        return _buldItemWidget(index);
      },
    );
  }
}
