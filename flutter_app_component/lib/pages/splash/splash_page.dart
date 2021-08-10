import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_component/generated/l10n.dart';
import 'package:flutter_app_component/pages/scaffold/scaffold_page.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jd_core/style/jd_colors.dart';
import 'package:jd_core/utils/jd_object_utils.dart';
import 'package:jd_core/utils/jd_utils.dart';

import 'splash_controller.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  ///逻辑
  SplashController controller = SplashController();

  @override
  void initState() {
    super.initState();

    ///初始化数据
    controller.initState();

    ///监听倒计时进度
    controller.addListener(() {
      setState(() {});
      if (controller.count == 0) {
        _goMain();
      }
    });
//    (context as Element).markNeedsBuild();
//    showAd = Random().nextBool();
  }

  Widget _buildSwiperWidage() {
    //初始化数据
    List<Widget> bannerList = _initBannerData();
    return Offstage(
        offstage: controller.showAd,
        child: Container(
          color: Colors.cyan,
          child: ObjectUtil.isEmpty(bannerList)
              ? Container()
              : Swiper(
                  loop: false,
                  pagination: const SwiperPagination(),
                  itemCount: bannerList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return bannerList[index];
                  }),
        ));
  }

  ///显示banner时组织数据
  List<Widget> _initBannerData() {
    List<Widget> bannerList = [];
    if (controller.showAd) {
      return bannerList;
    }
    List<String> guideList = controller.guideList;
    for (int i = 0, length = guideList.length; i < length; i++) {
      if (i == length - 1) {
        bannerList.add(Stack(
          children: <Widget>[
//            new Image(image: new  AssetImage(_guideList[i])),
            Image.asset(
              guideList[i],
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
        bannerList.add(Image.asset(
          guideList[i],
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ));
      }
    }
    return bannerList;
  }

  Widget _buildAdWidget() {
    return Offstage(
      offstage: !controller.showAd,
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
                      '${S.of(context).splash_title} ${controller.count}',
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

  void _goMain() {
    JDNavigationUtil.pushReplacement(ScaffoldPage());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
