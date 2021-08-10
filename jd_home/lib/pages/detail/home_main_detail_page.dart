import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jd_core/utils/jd_navigation_util.dart';
import 'package:jd_core/widget//button/jd_button.dart';

class HomeMainDetailPage extends StatefulWidget {
  @override
  _HomeMainDetailPageState createState() => _HomeMainDetailPageState();
}

class _HomeMainDetailPageState extends State<HomeMainDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('工作室详情'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
                bottom: 0,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '资产配置规范咨询',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff333333),
                              ),
                            ),
                            Text(
                              '江苏省 南京市',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff333333),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: const TextSpan(
                                  text: '服务类目: ',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                  children: [
                                    TextSpan(
                                      text: '管理咨询',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black87),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: const TextSpan(
                                  text: '收费价格: ',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                  children: [
                                    TextSpan(
                                      text: '面议',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black87),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        const Text(
                          '工作室简介',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        const Padding(
                          child: Text('我的工作室很漂亮'),
                          padding: EdgeInsets.only(top: 8.0),
                        ),
                        const Divider(),
                        const Text(
                          '工作室案例',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: RichText(
                            text: const TextSpan(
                              text: '项目名称:  ',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                              children: [
                                TextSpan(
                                  text: '很漂亮工作室',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: RichText(
                            text: const TextSpan(
                              text: '客户名称:  ',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                              children: [
                                TextSpan(
                                  text: '很漂亮',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: RichText(
                            text: const TextSpan(
                              text: '项目周期:  ',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                              children: [
                                TextSpan(
                                  text: '360Day',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(onPressed: () {}, child: Text('立即咨询')),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 150,
                width: 60,
                margin: const EdgeInsets.only(right: 10),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: JDButton(
                        action: () {
                          JDNavigationUtil.popToRoot();
                        },
                        width: 60,
                        height: 60,
                        icon: const Icon(Icons.home_sharp),
                        text: Text('首页'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: JDButton(
                          action: () {},
                          width: 60,
                          height: 60,
                          icon: const Icon(Icons.add),
                          text: Text('发布'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
