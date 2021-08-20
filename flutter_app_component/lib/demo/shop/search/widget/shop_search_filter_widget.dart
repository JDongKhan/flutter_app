import 'package:flutter/material.dart';
import 'package:jd_core/jd_core.dart';

/// @author jd
class ShopSearchFilterWidget extends StatefulWidget {
  @override
  _ShopSearchFilterWidgetState createState() => _ShopSearchFilterWidgetState();
}

class _ShopSearchFilterWidgetState extends State<ShopSearchFilterWidget> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ///城市选择器
                  _buildCityWidget(),
                  const SizedBox(
                    height: 10,
                  ),

                  ///价格区间title
                  const Text('价格区间'),
                  const SizedBox(
                    height: 10,
                  ),

                  ///价格选择
                  _buildPriceSelectedWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCityWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '配送城市',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        JDButton(
          icon: const Icon(Icons.location_on),
          imageDirection: AxisDirection.left,
          text: const Text('南京市'),
          action: () {},
        ),
      ],
    );
  }

  Widget _buildPriceSelectedWidget() {
    return Row(
      children: [
        Container(
          width: 100,
          child: TextField(
            keyboardType: TextInputType.number,
            maxLines: 1,
            controller: _controller1,
            textAlign: TextAlign.center,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: '最低价',
              filled: true,
              fillColor: Colors.grey[100],
              border: InputBorder.none,
              isCollapsed: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              // isDense: true,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          width: 50,
          height: 1,
          color: Colors.grey[100],
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          width: 100,
          color: Colors.grey[100],
          child: TextField(
            keyboardType: TextInputType.number,
            maxLines: 1,
            controller: _controller2,
            textAlign: TextAlign.center,
            textInputAction: TextInputAction.send,
            decoration: InputDecoration(
              hintText: '最高价',
              filled: true,
              fillColor: Colors.grey[100],
              border: InputBorder.none,
              isCollapsed: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              // isDense: true,
            ),
          ),
        ),
      ],
    );
  }
}
