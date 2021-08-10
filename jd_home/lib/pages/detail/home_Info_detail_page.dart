import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jd_core/utils/jd_asset_bundle.dart';
import 'package:jd_core/utils/jd_navigation_util.dart';
import 'package:jd_core/widget//loading/jd_loading.dart';
import 'package:jd_core/widget//userInfo/jd_userinfo_widget.dart';
import 'package:jd_core/widget/button/jd_button.dart';
import 'package:jd_home/pages/addInfo/home_add_info_page.dart';

class HomeInfoDetailPage extends StatefulWidget {
  HomeInfoDetailPage({
    this.userInfo,
  });

  final Map userInfo;

  @override
  _HomeInfoDetailPageState createState() => _HomeInfoDetailPageState();
}

class _HomeInfoDetailPageState extends State<HomeInfoDetailPage>
    with JDLoadingMixin {
  @override
  void initState() {
    super.initState();
    showLoading();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        stopLoading();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新品详情'),
      ),
      body: canShowLoading()
          ? loadingWidget()
          : Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 0),
                  color: Colors.black12,
                  child: ListView(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            JDUserInfoWidget(
                              userIcon: Image.asset(
                                JDAssetBundle.getImgPath(
                                    widget.userInfo['icon']),
                                width: 60,
                                height: 60,
                              ),
                              title: widget.userInfo['title'],
                              flag: widget.userInfo['type'],
                              rightWidget: Container(
                                width: 140,
                                height: 40,
                                child: Text(
                                  '${widget.userInfo['time']} 发布',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12.0),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                widget.userInfo['content'],
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 10),
                              child: RichText(
                                text: const TextSpan(
                                  text: '技术状态: ',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                  children: [
                                    TextSpan(
                                      text: '成熟阶段',
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
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.all(10),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.userInfo['content']),
                            _buildImageWidget(),
                            const Divider(),
                            _buildChartLine(),
                            _buildChartBar(),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                        left: 40,
                        right: 40,
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('拨打电话'),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 200,
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
                                action: () {
                                  JDNavigationUtil.push(HomeAddInfoPage());
                                },
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
                ),
              ],
            ),
    );
  }

  Widget _buildImageWidget() {
    Widget image = Container(
      margin: const EdgeInsets.all(5),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(10)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(10)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.asset(
          JDAssetBundle.getImgPath('ali_connors'),
        ),
      ),
    );

    List<Widget> children = [];
    for (int i = 0; i < 9; i++) {
      children.add(image);
    }
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: GridView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        children: children,
      ),
    );
  }

  Widget _buildChartLine() {
    List<Linesales> dataLine = [
      Linesales(DateTime(2020, 1, 1), 33),
      Linesales(DateTime(2020, 1, 2), 88),
      Linesales(DateTime(2020, 1, 3), 66),
      Linesales(DateTime(2020, 1, 4), 77),
      Linesales(DateTime(2020, 1, 5), 55),
    ];

    var seriesLine = [
      charts.Series<Linesales, DateTime>(
        data: dataLine,
        domainFn: (Linesales lines, _) => lines.time,
        measureFn: (Linesales lines, _) => lines.sale,
        id: 'Lines',
      )
    ];
    Widget line = charts.TimeSeriesChart(seriesLine);
    return Column(
      children: [
        const Text(
          '近期趋势',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Container(height: 200, child: line),
      ],
    );
  }

  Widget _buildChartBar() {
    List<Barsales> dataBar = [
      Barsales('1', 20),
      Barsales('2', 50),
      Barsales('3', 20),
      Barsales('4', 80),
      Barsales('5', 120),
      Barsales('6', 30),
      Barsales('7', 20),
    ];
    var seriesBar = [
      charts.Series(
        data: dataBar,
        domainFn: (Barsales sales, _) => sales.day,
        measureFn: (Barsales sales, _) => sales.sale,
        id: 'Sales',
      )
    ];
    return Column(
      children: [
        const Text(
          '近期数据',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Container(
          height: 200,
          child: charts.BarChart(seriesBar),
        ),
      ],
    );
  }
}

class Barsales {
  String day;
  int sale;
  Barsales(this.day, this.sale);
}

class Linesales {
  DateTime time;
  int sale;
  Linesales(this.time, this.sale);
}
