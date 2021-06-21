import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// @author jd

typedef CityWidgetClick = void Function(String selectValue);

class CityWidget extends StatefulWidget {
  final CityWidgetClick click;
  CityWidget({this.click});
  @override
  _CityWidgetState createState() => _CityWidgetState();
}

class _CityWidgetState extends State<CityWidget> {
  int _selectTempFirstLevelIndex = 0;
  int _selectFirstLevelIndex = 0;
  int _selectSecondLevelIndex = -1;

  List<Map<String, dynamic>> citys;

  @override
  void initState() {
    //初始化数据
    citys = List<Map<String, dynamic>>.generate(15, (index) {
      if (index == 0) {
        return {
          'title': '全城',
        };
      }

      List s = List<String>.generate(15, (int i) {
        if (index == 0) {
          return '全部';
        }
        return '$index-$i街道办';
      });

      return {
        'title': '区域-$index',
        'items': s,
      };
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List secondLevels = citys[_selectTempFirstLevelIndex]['items'];
    return Row(
      children: <Widget>[
        Container(
          width: 100,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView(
              children: citys.map(
                (item) {
                  int index = citys.indexOf(item);
                  return gestureDetector0(index, item);
                },
              ).toList(),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.grey[200],
            child: _selectTempFirstLevelIndex == 0
                ? Container()
                : MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView(
                      children: secondLevels.map(
                        (item) {
                          int index = secondLevels.indexOf(item);
                          return gestureDetector1(index, item);
                        },
                      ).toList(),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  GestureDetector gestureDetector0(int index, Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        _selectTempFirstLevelIndex = index;

        if (_selectTempFirstLevelIndex == 0) {
          if (widget.click != null) {
            widget.click(item['title']);
          }
        }
        setState(() {});
      },
      child: Container(
        height: 40,
        color: _selectTempFirstLevelIndex == index
            ? Colors.grey[100]
            : Colors.white,
        alignment: Alignment.center,
        child: _selectTempFirstLevelIndex == index
            ? Text(
                '${item["title"]}',
                style: const TextStyle(
                  color: Colors.red,
                ),
              )
            : Text('${item["title"]}'),
      ),
    );
  }

  GestureDetector gestureDetector1(int index, item) {
    return GestureDetector(
      onTap: () {
        _selectSecondLevelIndex = index;
        _selectFirstLevelIndex = _selectTempFirstLevelIndex;
        if (_selectSecondLevelIndex == 0) {
          if (widget.click != null) {
            widget.click(citys[_selectFirstLevelIndex]['title']);
          }
        } else {
          if (widget.click != null) {
            widget.click(item);
          }
        }
      },
      child: Container(
        height: 40,
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            const SizedBox(
              width: 20,
            ),
            _selectFirstLevelIndex == _selectTempFirstLevelIndex &&
                    _selectSecondLevelIndex == index
                ? Text(
                    '$item',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  )
                : Text('$item'),
          ],
        ),
      ),
    );
  }
}
