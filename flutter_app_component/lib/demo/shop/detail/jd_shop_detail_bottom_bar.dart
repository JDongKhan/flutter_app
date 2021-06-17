import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jd_core/jd_core.dart';

/// @author jd

class JDShopDetailBottomBar extends StatefulWidget {
  @override
  _JDShopDetailBottomBarState createState() => _JDShopDetailBottomBarState();
}

class _JDShopDetailBottomBarState extends State<JDShopDetailBottomBar> {
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
                text: const Text('收藏'),
                icon: const Icon(
                  Icons.collections,
                ),
              ),
              JDButton(
                action: () {},
                margin: const EdgeInsets.only(left: 10, right: 10),
                text: const Text('购物车'),
                icon: const Icon(
                  Icons.shop,
                ),
              ),
              JDButton(
                action: () {},
                margin: const EdgeInsets.only(left: 10, right: 10),
                text: const Text('客服'),
                icon: const Icon(
                  Icons.people,
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
