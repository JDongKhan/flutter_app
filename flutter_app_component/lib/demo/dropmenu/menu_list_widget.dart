import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// @author jd

class MenuCondition {
  String title;
  bool isSelected;

  MenuCondition({
    @required this.title,
    @required this.isSelected,
  });
}

typedef MenuListWidgetClick = void Function(String selectValue);

class MenuListWidget extends StatefulWidget {
  final MenuListWidgetClick click;
  final String selectedValue;
  MenuListWidget({this.click, this.selectedValue});

  @override
  _MenuListWidgetState createState() => _MenuListWidgetState();
}

class _MenuListWidgetState extends State<MenuListWidget> {
  List<MenuCondition> items = [
    MenuCondition(
      title: '全部',
      isSelected: true,
    ),
    MenuCondition(
      title: '格力',
      isSelected: false,
    ),
    MenuCondition(
      title: '海尔',
      isSelected: false,
    ),
    MenuCondition(
      title: '美的',
      isSelected: false,
    ),
    MenuCondition(
      title: '松下',
      isSelected: false,
    ),
    MenuCondition(
      title: '索尼',
      isSelected: false,
    ),
    MenuCondition(
      title: '惠普',
      isSelected: false,
    ),
    MenuCondition(
      title: '联想',
      isSelected: false,
    ),
  ];

  @override
  void initState() {
    for (var value in items) {
      if (value.title == widget.selectedValue) {
        value.isSelected = true;
      } else {
        value.isSelected = false;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Container(
        color: Colors.white,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: items.length,
          // item 的个数
          separatorBuilder: (BuildContext context, int index) =>
              Divider(height: 1.0),
          // 添加分割线
          itemBuilder: (BuildContext context, int index) {
            return gestureDetector(items, index, context);
          },
        ),
      ),
    );
  }

  GestureDetector gestureDetector(items, int index, BuildContext context) {
    MenuCondition condition = items[index];
    return GestureDetector(
      onTap: () {
        setState(() {
          for (var value in items) {
            value.isSelected = false;
          }
          condition.isSelected = true;
        });
        if (widget.click != null) {
          widget.click(condition.title);
        }
      },
      child: Container(
        //            color: Colors.blue,
        height: 40,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                condition.title,
                style: TextStyle(
                  color: condition.isSelected ? Colors.red : Colors.black,
                ),
              ),
            ),
            condition.isSelected
                ? Icon(
                    Icons.check,
                    color: Colors.red,
                    size: 16,
                  )
                : SizedBox(),
            SizedBox(
              width: 16,
            ),
          ],
        ),
      ),
    );
  }
}
