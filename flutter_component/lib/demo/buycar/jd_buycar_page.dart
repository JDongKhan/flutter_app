import 'package:flutter/material.dart';
import 'package:flutter_component/demo/notifier/jd_changenotifierprovider.dart';
/**
 *
 * @author jd
 *
 */

class JDItem {
  JDItem(this.price, this.count);
  double price; //商品单价
  int count; // 商品份数
//... 省略其它属性
}

class JDCartModel extends ChangeNotifier {
  // 用于保存购物车中商品列表
  final List<JDItem> _items = [];

  // 禁止改变购物车里的商品信息
//  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  // 购物车中商品的总价
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  // 将 [item] 添加到购物车。这是唯一一种能从外部改变购物车的方法。
  void add(JDItem item) {
    _items.add(item);
    // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }
}

class JDBuyCarPage extends StatefulWidget {
  final String title = "providerroute";

  @override
  State createState() => _JDBuyCarPageState();
}

class _JDBuyCarPageState extends State<JDBuyCarPage>
    with SingleTickerProviderStateMixin {
  GlobalKey _shopKey = GlobalKey();
  Offset _endOffset;
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 800), value: 0);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      RenderBox renderObj =
          _shopKey.currentContext.findRenderObject() as RenderBox;
      _endOffset = renderObj.localToGlobal(Offset.zero);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: JDChangeNotifierProvider(
          data: JDCartModel(),
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
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Icon(
              Icons.shop,
              key: _shopKey,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Builder(
              builder: (context) {
                var cart = JDChangeNotifierProvider.of<JDCartModel>(context);
                return Text("总价: ${cart.totalPrice}");
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListItem() {
    return ListView.builder(itemBuilder: (context, int index) {
      return ListTile(
        title: Text("我是商品名称${index}"),
        trailing: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: () {
                RenderBox box = context.findRenderObject() as RenderBox;
                _endOffset = box.localToGlobal(Offset.zero);
                JDChangeNotifierProvider.of<JDCartModel>(context)
                    .add(JDItem(20.0, 1));
              },
            );
          },
        ),
      );
    });
  }
}
