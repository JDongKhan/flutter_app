import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jd_core/jd_core.dart';

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
                action: () {},
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
                  onPressed: () {},
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
}
