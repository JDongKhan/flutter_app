import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jd_dropdowm_menu_widget/jd_drop_down_menu.dart';
import 'package:jd_dropdowm_menu_widget/jd_dropdowm_menu_widget.dart';
import 'package:jd_dropdowm_menu_widget/jd_pop_widget.dart';

import 'city_widget.dart';
import 'menu_list_widget.dart';

/// @author jd

class SortCondition {
  String name;
  bool isSelected;

  SortCondition({
    @required this.name,
    @required this.isSelected,
  });
}

class JDDropdownMenuDemoPage extends StatefulWidget {
  @override
  _JDDropdownMenuDemoPageState createState() => _JDDropdownMenuDemoPageState();
}

class _JDDropdownMenuDemoPageState extends State<JDDropdownMenuDemoPage> {
  String title1 = '城市';
  String title2 = '品牌';
  GlobalKey _key1 = GlobalKey();
  JDDropdownMenuController controller = JDDropdownMenuController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return WillPopScope(
      onWillPop: () async {
        if (controller.isShow) {
          controller.hide();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('下拉菜单'),
          actions: [
            TextButton(
                key: _key1,
                onPressed: () {
                  RenderBox renderBox = _key1.currentContext.findRenderObject();
                  Rect position =
                      renderBox.localToGlobal(Offset.zero) & renderBox.size;
                  showDropdownMenu(
                    position: position,
                    context: context,
                    pageBuilder: (c1) => Container(
                      color: Colors.orange,
                    ),
                  );
                },
                child: Text(
                  '下拉菜单',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ))
          ],
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              child: JDDropdownMenuWidget(
                controller: controller,
                itemStyle: JDDropdownMenuWidgetStyle.style2,
                click: (int index) {
                  print('$index');
                },
                items: [
                  JDDropdownMenuItem(
                    maxHeight: 300,
                    title: Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Text(title1),
                    ),
                    menu: CityWidget(
                      click: (String selectedValue) {
                        setState(() {
                          title1 = selectedValue;
                          controller.hide();
                        });
                        print('选择的城市为:$selectedValue');
                      },
                    ),
                  ),
                  JDDropdownMenuItem(
                    maxHeight: 300,
                    title: Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Text(title2),
                    ),
                    menu: MenuListWidget(
                      selectedValue: title2,
                      click: (String value) {
                        setState(() {
                          title2 = value;
                          controller.hide();
                        });
                      },
                    ),
                  ),
                  JDDropdownMenuItem(
                    title: Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Text('菜单3'),
                    ),
                    menu: Container(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Builder(
                builder: (c) {
                  return TextButton(
                      onPressed: () {
                        RenderBox renderBox = c.findRenderObject();
                        Rect position = renderBox.localToGlobal(Offset.zero) &
                            renderBox.size;
                        showDropdownMenu(
                          position: position,
                          context: c,
                          pageBuilder: (c1) => Container(
                            color: Color(0xffff0000),
                          ),
                        );
                      },
                      child: Text('Menu1'));
                },
              ),
            ),
            Container(
              child: Builder(
                builder: (c) {
                  return TextButton(
                      onPressed: () {
                        showPop(
                          barrierColor: const Color(0x80000000),
                          context: c,
                          items: ['个人信息', '退出'],
                        );
                      },
                      child: Text('Menu2'));
                },
              ),
            ),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
