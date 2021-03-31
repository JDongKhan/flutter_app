import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 * flutter_staggered_grid_view  可实现交叉布局
 *
 */

class JDGridViewPage extends StatefulWidget {

  final String title = "gridview";

  @override
  State createState() => _JDGridViewPageState();
}

class _JDGridViewPageState extends State<JDGridViewPage> {

  List<IconData> _icons = []; //保存Icon数据

  @override
  void initState() {
    // 初始化数据
    _retrieveIcons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, //每行三列
                childAspectRatio: 1.0 //显示区域宽高相等
            ),
            itemCount: _icons.length,
            itemBuilder: (context, index) {
              //如果显示到最后一个并且Icon总数小于200时继续获取数据
              if (index == _icons.length - 1 && _icons.length < 200) {
                _retrieveIcons();
              }
              return Icon(_icons[index]);
            }
        ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  //模拟异步获取数据
  void _retrieveIcons() {
    Future<dynamic>.delayed(const Duration(milliseconds: 200)).then((dynamic e) {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access, Icons.cake,
          Icons.free_breakfast
        ]);
      });
    });
  }

}