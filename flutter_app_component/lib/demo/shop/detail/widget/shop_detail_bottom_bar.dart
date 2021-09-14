import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/demo/shop/shop_main_page.dart';
import 'package:jd_core/jd_core.dart';
import 'package:jd_core/widget/number_controller/jd_step_number_widget.dart';

/// @author jd

class ShopDetailBottomBar extends StatefulWidget {
  @override
  _ShopDetailBottomBarState createState() => _ShopDetailBottomBarState();
}

class _ShopDetailBottomBarState extends State<ShopDetailBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey[200],
              ),
            ),
          ),
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Row(
            children: [
              JDButton(
                action: () {},
                margin: const EdgeInsets.only(left: 10, right: 10),
                text: const Text(
                  '收藏',
                  style: TextStyle(fontSize: 12),
                ),
                icon: const Icon(
                  Icons.collections,
                  color: Colors.grey,
                ),
              ),
              JDButton(
                action: () {
                  ShopMainPage.of(context).toCar(context);
                },
                margin: const EdgeInsets.only(left: 10, right: 10),
                text: const Text(
                  '购物车',
                  style: TextStyle(fontSize: 12),
                ),
                icon: const Icon(
                  Icons.shop,
                  color: Colors.grey,
                ),
              ),
              JDButton(
                action: () {},
                margin: const EdgeInsets.only(left: 10, right: 10),
                text: const Text(
                  '客服',
                  style: TextStyle(fontSize: 12),
                ),
                icon: const Icon(
                  Icons.people,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    _showMenuWidget();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    '立即购买',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMenuWidget() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Image.asset(
                      JDAssetBundle.getImgPath('shop_0'),
                      width: 60,
                      height: 60,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          '￥100.00',
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '商品编码',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        )
                      ],
                    )
                  ],
                ),
                SelectTypeWidget(
                  '家电类别',
                  ['波轮洗衣机', '美的洗衣机', '全铜洗衣机', '美式战斗机', '全铜洗衣机2', '美式战斗机2'],
                  (int index) {},
                ),
                SelectTypeWidget(
                  '服务项目',
                  ['安装服务'],
                  (int index) {},
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '购买数量',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    JDStepNumberWidget(value: 1, onChanged: (value) {}),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                const Divider(),
                Container(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      primary: Colors.white,
                    ),
                    child: const Text('确定'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SelectTypeWidget extends StatefulWidget {
  const SelectTypeWidget(this.title, this.types, this.selectedChanged);
  final String title;
  final List<String> types;
  final ValueChanged<int> selectedChanged;
  @override
  _SelectTypeWidgetState createState() => _SelectTypeWidgetState();
}

class _SelectTypeWidgetState extends State<SelectTypeWidget> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildTypeWidget(widget.title, widget.types),
    );
  }

  List<Widget> _buildTypeWidget(String title, List<String> types) {
    List<Widget> myWidgets = [];
    myWidgets.add(const SizedBox(
      height: 10,
    ));
    myWidgets.add(Text(
      title,
      style: const TextStyle(color: Colors.black, fontSize: 14),
    ));

    myWidgets.add(const SizedBox(
      height: 10,
    ));

    List<Widget> widgets = types
        .map(
          (e) => GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = types.indexOf(e);
              });
              if (widget.selectedChanged != null) {
                widget.selectedChanged(_selectedIndex);
              }
            },
            child: Container(
              color: types.indexOf(e) == _selectedIndex
                  ? Colors.blue[100]
                  : Colors.white,
              padding: const EdgeInsets.all(5),
              child: Text(
                e,
                style: const TextStyle(color: Colors.blue, fontSize: 12),
              ),
            ),
          ),
        )
        .toList();

    myWidgets.add(
      Wrap(
        spacing: 10,
        runSpacing: 10,
        children: widgets,
      ),
    );
    return myWidgets;
  }
}
