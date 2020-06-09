import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */

class JDImageViewPage extends StatefulWidget {

  final String title = "jd_imageview";

  @override
  State createState() => _JDImageViewPageState();
}

class _JDImageViewPageState extends State<JDImageViewPage> {

  String netUrl1 =
      "https://upload-images.jianshu.io/upload_images/13222938-74a4dc4115d76790.png";
  String netUrl2 =
      "https://upload-images.jianshu.io/upload_images/13222938-74a4dc4115d76790.png";
  String localImgUrl = "assets/images/3.0x/ali_connors.png";

  @override
  void initState() {
    super.initState();
    _loadCachedNetworkImage();
    _loadNetUrl1();
    _loadLocalUrl1();
    _initAsync2();
  }


  void _loadNetUrl1() async {
    var barHeight = kToolbarHeight;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
//    Rect rect = await WidgetUtil.getImageWH(url: netUrl1);
//    netImgInfo1 = "[网络图片1] width: ${rect.width}, height: ${rect.height}";
//    setState(() {});
  }

  void _loadLocalUrl1() async {
//    Rect locImg1 = await WidgetUtil.getImageWH(localUrl: localImgUrl);
//    localImgInfo1 =
//    "[本地图片 ali_connors] width: ${locImg1.width}, height: ${locImg1.height}";
//    setState(() {});
  }


  void _loadCachedNetworkImage() async {
    Image image = new Image(image: new CachedNetworkImageProvider(netUrl2));
//    Rect rect = await WidgetUtil.getImageWH(image: image);
//    cacheImgInfo1 =
//    "[CachedNetworkImage] width: ${rect.width}, height: ${rect.height}";
//    setState(() {});

//    Image imageAsset = new Image.asset("");
//    Image imageFile = new Image.file(File("path"));
//    Image imageNetwork = new Image.network("url");
//    Image imageMemory = new Image.memory(null);
  }


  void _initAsync2() {
//    WidgetUtil.getImageWHE(url: netUrlE).then((Rect rect) {
//      netImgInfoE = "[网络图片2] width: ${rect.width}, height: ${rect.height}";
//      setState(() {});
//    }).catchError((error) {
//      netImgInfoE = "[网络图片2] error" + error.toString();
//      setState(() {});
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
              children: <Widget>[
              ]
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}