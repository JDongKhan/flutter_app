import 'package:flutter/material.dart';
import 'package:tableview/tableview.dart';

/// @author jd
class ThirdPartyTableViewDemoPage extends StatefulWidget {
  @override
  _ThirdPartyTableViewDemoPageState createState() =>
      _ThirdPartyTableViewDemoPageState();
}

class _ThirdPartyTableViewDemoPageState
    extends State<ThirdPartyTableViewDemoPage> {
  // 设置数据源，scrollBar的数据原
  static List<String> headerList = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "G",
    "H",
    "J",
    "K",
    "L",
    "M",
    "N",
    "P",
    "Q",
    "S",
    "T",
    "W",
    "X",
    "Y",
    "Z"
  ];
  // 设置tableView的数据源，如果需要显示section，数据源就是二位数据
  static List<List<String>> rowList = [
    ["阿昌族"],
    ["白族", "保安族", "布朗族", "布依族"],
    ["藏族", "朝鲜族"],
    ["傣族", "达斡尔族", "德昂族", "东乡族", "侗族", "独龙族"],
    ["鄂伦春族", "俄罗斯族", "鄂温克族"],
    ["高山族", "仡佬族"],
    ["哈尼族", "汉族", "哈萨克族", "赫哲族", "回族"],
    ["景颇族", "京族", "基诺族"],
    ["柯尔克孜族"],
    ["拉祜族", "傈僳族", "黎族", "珞巴族"],
    ["满族", "毛南族", "门巴族", "蒙古族", "苗族", "仫佬族"],
    ["纳西族", "怒族"],
    ["普米族"],
    ["羌族"],
    ["撒拉族", "畲族", "水族"],
    ["塔吉克族", "塔塔尔族", "土家族", "土族"],
    ["佤族", "维吾尔族", "乌孜别克族"],
    ["锡伯族"],
    ["瑶族", "彝族", "裕固族"],
    ["壮族"]
  ];
  int choseSection = 0;
  String title = "";

  double btnWidth = 60;
  int num = 5;
  double space = 10;

  @override
  void initState() {
    super.initState();
  }

// tableview的代理，用于设置tableview的section个数，cell个数，section(header)高度，cell高度,每个cell和section的样式
  var delegate = TableViewDelegate(numberOfSectionsInTableView: () {
    return headerList.length;
  }, numberOfRowsInSection: (int section) {
    return rowList[section].length;
  }, heightForHeaderInSection: (int section) {
    return 20;
  }, heightForRowAtIndexPath: (IndexPath indexPath) {
    return 40;
  }, viewForHeaderInSection: (BuildContext context, int section) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 10),
      color: Color.fromRGBO(220, 220, 220, 1),
      height: 20,
      child: Text(headerList[section]),
    );
  }, cellForRowAtIndexPath: (BuildContext context, IndexPath indexPath) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop(rowList[indexPath.section][indexPath.row]);
      },
      child: Container(
        color: Colors.white,
        height: 40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  rowList[indexPath.section][indexPath.row],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Divider(
              indent: 10,
              endIndent: 10,
              height: 1,
            ),
          ],
        ),
      ),
    );
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TableView Demo'),
      ),
      body: NotificationListener<TableViewNotifier>(
        onNotification: (notification) {
          // tableview滚动更改了悬停section会通知出来

          choseSection = notification.scrollSection;
          setState(() {});
          return true;
        },
        child: TableView(
          delegate: delegate,
          // scrollbar的样式，可通过 implements TableViewScrollBar 自定义，如果同时设置startAlignment和endAlignment会有滑动效果，如效果2所示
          scrollbar: TableViewHeaderScrollBar(
            headerTitleList: headerList,
            itemHeight: 20,
            startAlignment: Alignment.centerRight,
            choseSection: choseSection,
            indexChanged: (index) {
              // scrollBar改变索引
              title = headerList[index];
              choseSection = index;
              setState(() {});
            },
            gestureFinished: () {
              // 手势抬起
              title = "";
              setState(() {});
            },
          ),
          // scrollBar点击中间提示的Widget，可通过implement TableViewCenterTip自定义，无设置则无提示效果
          centerTip: TableViewCenterTitle(
            alignment: Alignment.center,
            title: title,
          ),
        ),
      ),
    );
  }
}
