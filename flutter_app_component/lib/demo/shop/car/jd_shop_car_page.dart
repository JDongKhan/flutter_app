import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/component/circle_check_box.dart';
import 'package:flutter_app_component/component/number_controller/number_controller_widget.dart';
import 'package:flutter_app_component/demo/notifier/jd_changenotifierprovider.dart';
import 'package:flutter_app_component/demo/shop/model/jd_shop_info.dart';
import 'package:jd_core/jd_core.dart';

/// @author jd

class JDCarItem {
  JDCarItem(this.shopInfo, this.count);
  int count; // 商品份数
  JDShopInfo shopInfo; //商品信息
//... 省略其它属性
}

class JDCartModel extends ChangeNotifier {
  // 用于保存购物车中商品列表
  final List<JDCarItem> _items = [];

  // 禁止改变购物车里的商品信息
//  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  // 购物车中商品的总价
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.shopInfo.price);

  // 将 [item] 添加到购物车。这是唯一一种能从外部改变购物车的方法。
  void add(JDCarItem item) {
    _items.add(item);
    // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }

  // 将 [item] 添加到购物车。这是唯一一种能从外部改变购物车的方法。
  void addAll(List<JDCarItem> list) {
    _items.addAll(list);
    // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }

  void remove(JDCarItem item) {
    _items.remove(item);
    // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }
}

class JDShopCarPage extends StatefulWidget {
  @override
  _JDShopCarPageState createState() => _JDShopCarPageState();
}

class _JDShopCarPageState extends State<JDShopCarPage> {
  JDCartModel cartModel = JDCartModel();
  List<JDCarItem> carList = [];

  get allChecked => carList.length == cartModel._items.length;

  @override
  void initState() {
    super.initState();

    carList.add(
      JDCarItem(
          JDShopInfo(
            icon: JDAssetBundle.getImgPath('defalut_product'),
            shop_name: '潘婷染烫修护润发精华素750ml修复烫染损伤受损干枯发质',
            price: 48.80,
          ),
          1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('购物车'),
          actions: [
            TextButton(
              child: Text('添加购物车'),
              onPressed: () {
                setState(() {
                  carList.add(
                    JDCarItem(
                        JDShopInfo(
                          icon: JDAssetBundle.getImgPath('defalut_product'),
                          shop_name: '潘婷染烫修护润发精华素750ml修复烫染损伤受损干枯发质',
                          price: 48.80,
                        ),
                        1),
                  );
                });
              },
            ),
          ],
        ),
        body: JDChangeNotifierProvider<JDCartModel>(
          data: cartModel,
          child: Column(
            children: <Widget>[
              Expanded(
                child: _buildListItem(),
              ),
              Container(
                height: 1,
                color: Colors.grey.withOpacity(0.5),
              ),
              _buildShopCarBottomView()
            ],
          ),
        ));
  }

  Widget _buildShopCarBottomView() {
    return Container(
      height: 60,
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      color: Colors.white,
      child: Builder(
        builder: (BuildContext context) {
          var cart = JDChangeNotifierProvider.of<JDCartModel>(context);
          return Row(
            children: <Widget>[
              CircleCheckBox(
                value: allChecked,
                onChanged: (value) {
                  setState(() {
                    cartModel._items.clear();
                    if (value) {
                      cartModel.addAll(carList);
                    }
                  });
                },
              ),
              const Text('全选'),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text("总价: ${cart.totalPrice}"),
              ),
              const SizedBox(
                width: 10,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 25,
                    right: 25,
                  ),
                  primary: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {},
                child: const Text('去结算'),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildListItem() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: carList.length,
        itemBuilder: (context, int index) {
          JDCartModel model = JDChangeNotifierProvider.of<JDCartModel>(context);
          JDCarItem item = carList[index];
          bool checked = model._items.contains(item);
          return Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            color: Colors.white,
            child: Row(
              children: [
                CircleCheckBox(
                  value: checked,
                  onChanged: (value) {
                    if (value) {
                      model.add(item);
                    } else {
                      model.remove(item);
                    }
                  },
                ),
                Image.asset(
                  item.shopInfo.icon,
                  width: 80,
                  height: 80,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(item.shopInfo.shop_name),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        '商品编码： 000000101029384',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        '控油洁面',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '￥${item.shopInfo.price}',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          NumberControllerWidget(
                            updateChanged: (v) {
                              print(v);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
