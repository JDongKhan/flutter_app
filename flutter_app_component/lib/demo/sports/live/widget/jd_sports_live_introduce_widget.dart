import 'package:flutter/material.dart';
import 'package:jd_core/jd_core.dart';

/// @author jd

class JDSportsLiveIntroduceWidget extends StatefulWidget {
  @override
  _JDSportsLiveIntroduceWidgetState createState() =>
      _JDSportsLiveIntroduceWidgetState();
}

class _JDSportsLiveIntroduceWidgetState
    extends State<JDSportsLiveIntroduceWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          ///开通会员
          _buildMemberPayButton(),

          ///title
          _buildTitleWidget(),

          ///分割线
          _buildDivider(),

          ///节目信息
          _buildProgramInfoWidget(),

          ///分割线
          _buildDivider(),

          ///广告
          _buildAd(),
        ],
      ),
    );
  }

  Widget _buildMemberPayButton() {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: TextButton(
        onPressed: () {},
        child: const Text(
          '开通体育会员，畅享精彩赛事',
          style: TextStyle(color: Colors.red),
        ),
        style: TextButton.styleFrom(
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Row(
        children: [
          Icon(
            Icons.live_tv,
            color: Colors.red,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Text(
            '2021JJ斗地主冠军杯-秋季赛海选',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      thickness: 10,
      color: Colors.grey[100],
    );
  }

  Widget _buildProgramInfoWidget() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 5,
              height: 25,
              color: Colors.red,
              margin: const EdgeInsets.only(right: 10),
            ),
            Text(
              '本场解说',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              width: 150,
              height: 100,
              color: Colors.grey[100],
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '直播中',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        Text('PP体育'),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      color: Colors.orange,
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        '免费',
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAd() {
    return Image.asset(
      JDAssetBundle.getImgPath('bg_banner'),
    );
  }
}
