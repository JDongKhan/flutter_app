import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/demo/shop/model/shop_info.dart';
import 'package:jd_core/jd_core.dart';

/// @author jd

class ShopCar2Page extends StatefulWidget {
  const ShopCar2Page({Key key, this.shopInfoList}) : super(key: key);
  final List<ShopInfo> shopInfoList;
  @override
  _ShopCar2PageState createState() => _ShopCar2PageState();
}

class _ShopCar2PageState extends State<ShopCar2Page> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('确认订单'),
      ),
      body: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(10),
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            _buildAddress(),
            const SliverPadding(padding: EdgeInsets.only(top: 10)),
            _buildInfo(),
            const SliverPadding(padding: EdgeInsets.only(top: 10)),
            _buildPay(),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('实付金额  ￥0'),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 10,
                    bottom: 10,
                    right: 20,
                  ),
                ),
                child: const Text(
                  '提交订单',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 收货地址
  Widget _buildAddress() {
    return SliverToBoxAdapter(
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(5),
          ),
        ),
        // color: Colors.white,
        child: ListTile(
          minLeadingWidth: 20,
          onTap: () {},
          contentPadding: const EdgeInsets.only(left: 10, right: 10),
          leading: const Icon(Icons.add),
          title: const Text('选择收货地址'),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
            color: Colors.grey[400],
          ),
        ),
      ),
    );
  }

  /// 商品信息
  Widget _buildInfo() {
    ShopInfo shopInfo = widget.shopInfoList.first;
    return SliverToBoxAdapter(
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(5),
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '自营产品',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Image.asset(
                  shopInfo.icon,
                  width: 80,
                  height: 80,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shopInfo.shop_name,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            shopInfo.price.toString(),
                          ),
                          Text(
                            (shopInfo.price * 1).toString(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///支付
  Widget _buildPay() {
    return SliverToBoxAdapter(
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(5),
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '支付方式*',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                JDButton(
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey[400],
                    size: 14,
                  ),
                  text: const Text(
                    '请选择支付方法',
                    style: TextStyle(fontSize: 14),
                  ),
                  imageDirection: AxisDirection.right,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  '发票信息*',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                JDButton(
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: Colors.grey[400],
                  ),
                  text: const Text(
                    '去填写',
                    style: TextStyle(fontSize: 14),
                  ),
                  imageDirection: AxisDirection.right,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  '备注',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: 200,
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: '点击此填写备注',
                      hintStyle: TextStyle(fontSize: 14),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 80),
                      // isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
