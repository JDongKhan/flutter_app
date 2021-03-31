import 'dart:typed_data';
import 'dart:ui';

// import 'package:albumsaver/albumsaver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';

/**
 *
 * @author jd
 *
 */

class JDMyQRcodePage extends StatefulWidget {
  final String title = "我的二维码";

  @override
  State createState() => _JDMyQRcodePageState();
}

class _JDMyQRcodePageState extends State<JDMyQRcodePage> {
  GlobalKey _repaintKey = GlobalKey();

  var _tips_string = '我的二维码';
  var _tips1_string = '免费领取';
  var _qr_string = 'https://jdongkhan.github.io/myhome/';
  var _font_size = 12.0;
  var _font1_size = 12.0;

  final TextEditingController _qrController = TextEditingController();
  final TextEditingController _tipsController = TextEditingController();
  final TextEditingController _tips1Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1, //隐藏底部阴影
          title: Text(widget.title),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Column(children: <Widget>[
                RepaintBoundary(
                  key: _repaintKey,
                  child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(top: 50),
                      ),
                      Text(
                        _tips_string,
                        style: TextStyle(fontSize: _font_size),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Text(
                        _tips1_string,
                        style: TextStyle(fontSize: _font1_size),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      QrImage(
                        data: _qr_string,
                        size: 200,
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 50),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _qrController,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (String input) {},
                        decoration: const InputDecoration(
                          labelText: '请输入二维码信息',
                        ),
                      ),
                    ),
                    FlatButton(
                      color: Colors.blue,
                      highlightColor: Colors.blue[700],
                      colorBrightness: Brightness.dark,
                      splashColor: Colors.grey,
                      child: const Text('确定'),
                      onPressed: () {
                        setState(() {
                          _qr_string = _qrController.text;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _tipsController,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (String input) {},
                        decoration: const InputDecoration(
                          labelText: '请输入上面提示文本',
                        ),
                      ),
                    ),
                    FlatButton(
                      color: Colors.blue,
                      highlightColor: Colors.blue[700],
                      colorBrightness: Brightness.dark,
                      splashColor: Colors.grey,
                      child: const Text('确定'),
                      onPressed: () {
                        setState(() {
                          _tips_string = _tipsController.text;
                        });
                      },
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Text('提示文本字体大小:$_font_size'),
                Slider(
                  value: _font_size,
                  min: 10,
                  max: 60,
                  divisions: 50,
                  label: '${_font_size.toStringAsFixed(1)}',
                  activeColor: Colors.orangeAccent,
                  inactiveColor: Colors.green.withAlpha(99),
                  onChanged: (value) {
                    setState(() {
                      _font_size = value;
                    });
                  },
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _tips1Controller,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (String input) {},
                        decoration: const InputDecoration(
                          labelText: '请输入上面提示文本',
                        ),
                      ),
                    ),
                    FlatButton(
                      color: Colors.blue,
                      highlightColor: Colors.blue[700],
                      colorBrightness: Brightness.dark,
                      splashColor: Colors.grey,
                      child: const Text('确定'),
                      onPressed: () {
                        setState(() {
                          _tips1_string = _tips1Controller.text;
                        });
                      },
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Text('提示文本字体大小:$_font1_size'),
                Slider(
                  value: _font1_size,
                  min: 10,
                  max: 60,
                  divisions: 50,
                  label: '${_font1_size.toStringAsFixed(1)}',
                  activeColor: Colors.orangeAccent,
                  inactiveColor: Colors.green.withAlpha(99),
                  onChanged: (double value) {
                    setState(() {
                      _font1_size = value;
                    });
                  },
                ),
                FlatButton(
                  color: Colors.blue,
                  highlightColor: Colors.blue[700],
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  child: const Text('保存二维码'),
                  onPressed: () {
                    _capturePng();
                  },
                ),
              ]),
            )
          ],
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Future<Uint8List> _capturePng() async {
    var status = await Permission.camera.status;
    var status1 = await Permission.photos.status;
    if (status.isDenied) {
      //无权限
      openAppSettings();
      print('没有权限');
      return null;
    }

    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();

    //生成图片
    try {
      final RenderRepaintBoundary boundary = _repaintKey.currentContext
          .findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      //保存图片
      // final bool result =
      //     await Albumsaver.saveImage(pngBytes.buffer.asUint8List());
      // print(result);
      // if (result) {
      //   JDToast.toast('保存成功');
      // } else {
      //   JDToast.toast('保存失败');
      // }
    } catch (e) {
      print(e);
    }

    return null;
  }
}
