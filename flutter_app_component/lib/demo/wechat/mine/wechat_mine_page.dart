import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jd_core/jd_core.dart';

/// @author jd

class WechatMinePage extends StatefulWidget {
  @override
  _WechatMinePageState createState() => _WechatMinePageState();
}

class _WechatMinePageState extends State<WechatMinePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: ListView(
        children: [
          _buildUserHeadWidget(),
          Divider(height: 10, color: Colors.grey[100]),
          _buildMenu(Icons.payment, '支付'),
          Divider(height: 10, color: Colors.grey[100]),
          _buildMenu(Icons.favorite, '收藏'),
          Divider(height: 1, color: Colors.grey[100]),
          _buildMenu(Icons.circle, '朋友圈'),
          Divider(height: 1, color: Colors.grey[100]),
          _buildMenu(Icons.backpack, '卡包'),
          Divider(height: 1, color: Colors.grey[100]),
          _buildMenu(Icons.face, '表情'),
          Divider(height: 10, color: Colors.grey[100]),
          _buildMenu(Icons.settings, '设置'),
          Divider(height: 1, color: Colors.grey[100]),
        ],
      ),
    );
  }

  Widget _buildUserHeadWidget() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(
        left: 20,
        top: 20,
        right: 10,
        bottom: 20,
      ),
      child: SafeArea(
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                JDAssetBundle.getImgPath('user_head_0'),
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('apple'),
                  SizedBox(
                    height: 10,
                  ),
                  Text('微信号：myheartforapple'),
                  SizedBox(
                    height: 5,
                  ),
                  Text('+状态 '),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_sharp,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenu(IconData iconData, String menu) {
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: Icon(iconData),
        title: Text(menu),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
        ),
      ),
    );
  }
}
