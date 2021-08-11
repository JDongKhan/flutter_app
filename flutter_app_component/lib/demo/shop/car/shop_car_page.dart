import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/component/circle_check_box.dart';
import 'package:flutter_app_component/component/number_controller/step_number_widget.dart';
import 'package:flutter_app_component/demo/databtransfer/notifier/jd_changenotifierprovider.dart';
import 'package:flutter_app_component/demo/shop/model/shop_info.dart';
import 'package:jd_core/jd_core.dart';

import 'shop_car2_page.dart';

/// @author jd

class CarItem {
  CarItem(this.shopInfo, this.count);
  int count; // 商品份数
  ShopInfo shopInfo; //商品信息
//... 省略其它属性
}

class CartModel extends ChangeNotifier {
  // 用于保存购物车中商品列表
  final List<CarItem> _items = [];

  // 禁止改变购物车里的商品信息
//  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  // 购物车中商品的总价
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.shopInfo.price);

  // 将 [item] 添加到购物车。这是唯一一种能从外部改变购物车的方法。
  void add(CarItem item) {
    _items.add(item);
    // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }

  // 将 [item] 添加到购物车。这是唯一一种能从外部改变购物车的方法。
  void addAll(List<CarItem> list) {
    _items.addAll(list);
    // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }

  void remove(CarItem item) {
    _items.remove(item);
    // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }
}

class ShopCarPage extends StatefulWidget {
  @override
  _ShopCarPageState createState() => _ShopCarPageState();
}

class _ShopCarPageState extends State<ShopCarPage> {
  CartModel cartModel = CartModel();
  List<CarItem> carList = [];

  get allChecked => carList.length == cartModel._items.length;

  @override
  void initState() {
    super.initState();

    carList.add(
      CarItem(
          ShopInfo(
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
          elevation: 1,
          title: const Text('购物车'),
          actions: [
            TextButton(
              child: const Text('添加购物车'),
              onPressed: () {
                setState(() {
                  carList.add(
                    CarItem(
                        ShopInfo(
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
        body: JDChangeNotifierProvider<CartModel>(
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
          var cart = JDChangeNotifierProvider.of<CartModel>(context);
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
                child: Text('总价: ${cart.totalPrice}'),
              ),
              const SizedBox(
                width: 10,
              ),
              Builder(
                builder: (context) => TextButton(
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
                  onPressed: () {
                    CartModel model =
                        JDChangeNotifierProvider.of<CartModel>(context);
                    if (model._items.isEmpty) {
                      JDToast.toast('请选择商品');
                      return;
                    }
                    List<ShopInfo> shopInfos =
                        model._items.map((e) => e.shopInfo).toList();
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (c) => ShopCar2Page(
                          shopInfoList: shopInfos,
                        ),
                      ),
                    );
                  },
                  child: const Text('去结算'),
                ),
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
          CartModel model = JDChangeNotifierProvider.of<CartModel>(context);
          CarItem item = carList[index];
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
                              fontFamily: 'PingFang SC',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          StepNumberWidget(
                            min: 0,
                            max: 10,
                            onChanged: (v) {
                              debugPrint(v.toString());
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
