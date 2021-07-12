import 'package:flutter/material.dart';
import 'package:jd_core/jd_core.dart';

class JDSportsLiveStoreWidget extends StatefulWidget {
  @override
  _JDSportsLiveStoreWidgetState createState() =>
      _JDSportsLiveStoreWidgetState();
}

class _JDSportsLiveStoreWidgetState extends State<JDSportsLiveStoreWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildTimerWidget(),
          Expanded(
            child: _buildListWidget(),
          ),
        ],
      ),
    );
  }

  Widget _buildTimerWidget() {
    return Container(
      height: 40,
      child: Row(
        children: [
          Container(
            width: 5,
            height: 20,
            color: Colors.red,
          ),
          SizedBox(
            width: 10,
          ),
          Text('限时抢购 07:46:23 后结束'),
        ],
      ),
    );
  }

  Widget _buildListWidget() {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _buildListCell(index);
        },
        itemCount: 50,
      ),
    );
  }

  Widget _buildListCell(int index) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            JDAssetBundle.getImgPath('shop_${index % 5}'),
            width: 100,
            height: 100,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '阿迪达斯 阳帽男帽女帽棒球帽运动帽户外跑步鸭舌帽FK0891',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 40),
                  child: LinearProgressIndicator(
                    value: 0.5,
                    backgroundColor: Colors.grey,
                    minHeight: 5,
                    valueColor: AlwaysStoppedAnimation(Colors.red),
                    semanticsLabel: '61%,',
                    semanticsValue: '已抢购183件',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '￥68',
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '99',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                      child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                          ),
                          child: Text(
                            '马上抢',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          )),
                    )
                  ],
                ),
                Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
