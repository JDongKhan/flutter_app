import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_component/generated/l10n.dart';
import 'package:flutter_app_component/pages/scaffold/jd_scaffold_page.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jd_core/style/jd_colors.dart';
import 'package:jd_core/utils/jd_object_utils.dart';
import 'package:jd_core/utils/jd_timer_utils.dart';
import 'package:jd_core/utils/jd_utils.dart';

class JDSplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _JDSplashPageState();
  }
}

class _JDSplashPageState extends State<JDSplashPage> {
  TimerUtil _timerUtil;

  final List<String> _guideList = <String>[
    JDAssetBundle.getImgPath('guide1'),
    JDAssetBundle.getImgPath('guide2'),
    JDAssetBundle.getImgPath('guide3'),
    JDAssetBundle.getImgPath('guide4'),
  ];

  final List<Widget> _bannerList = <Widget>[];

  int _count = 5;
  bool showAd = true;

  @override
  void initState() {
    super.initState();
//    (context as Element).markNeedsBuild();
//    showAd = Random().nextBool();
    if (!showAd) {
      _initBannerData();
    } else {
      _doCountDown();
    }
  }

  void _initBannerData() {
    for (int i = 0, length = _guideList.length; i < length; i++) {
      if (i == length - 1) {
        _bannerList.add(Stack(
          children: <Widget>[
//            new Image(image: new  AssetImage(_guideList[i])),
            Image.asset(
              _guideList[i],
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 160.0),
                child: InkWell(
                  onTap: () {
                    _goMain();
                  },
                  child: const CircleAvatar(
                    radius: 48.0,
                    backgroundColor: Colors.indigoAccent,
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        '立即体验',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
      } else {
        _bannerList.add(Image.asset(
          _guideList[i],
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ));
      }
    }
  }

  void _doCountDown() {
    _timerUtil = TimerUtil(mTotalTime: 5 * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      final double _tick = tick / 1000;
      setState(() {
        _count = _tick.toInt();
      });
      if (_tick == 0) {
        _goMain();
      }
    });
    _timerUtil.startCountDown();
    // Future.delayed(Duration(seconds: 5), () => _goMain());
  }

  void _goMain() {
    JDNavigationUtil.pushReplacement(JDScaffoldPage());
  }

  Widget _buildSwiperWidage() {
    return Offstage(
        offstage: showAd,
        child: Container(
          color: Colors.cyan,
          child: ObjectUtil.isEmpty(_bannerList)
              ? Container()
              : Swiper(
                  pagination: const SwiperPagination(),
                  itemCount: _bannerList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _bannerList[index];
                  }),
        ));
  }

  Widget _buildAdWidget() {
    return Offstage(
      offstage: !showAd,
      child: InkWell(
        onTap: () {
          _goMain();
          JDNavigationUtil.pushWebView(title: "测试", url: "https://baidu.com");
        },
        child: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/splash_bg.png',
              width: double.infinity,
              fit: BoxFit.fill,
              height: double.infinity,
            ),
            Container(
              alignment: Alignment.center,
              child: CachedNetworkImage(
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill,
                imageUrl:
                    'http://ww1.sinaimg.cn/large/7a8aed7bgw1ewc4irf4syj20go0ltdjk.jpg',
                placeholder: (context, url) => Image.asset(
                  'assets/images/splash_bg.png',
                  width: double.infinity,
                  fit: BoxFit.fill,
                  height: double.infinity,
                ),
                errorWidget: (context, url, dynamic error) => Image.asset(
                  'assets/images/splash_bg.png',
                  width: double.infinity,
                  fit: BoxFit.fill,
                  height: double.infinity,
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  _goMain();
                },
                child: Container(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      '${S.of(context).splash_title} $_count',
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                        color: const Color(0x66000000),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        border:
                            Border.all(width: 0.33, color: JDColors.divider))),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          // const Text("Helloworld"),
          _buildSwiperWidage(),
          _buildAdWidget(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (_timerUtil != null) _timerUtil.cancel(); //记得在dispose里面把timer cancel。
    super.dispose();
  }
}
