//import 'package:flt_video_player/flt_video_player.dart';
//import 'package:flutter/material.dart';
//
///// @author jd
//
//
//class JDPlayer extends StatefulWidget {
//  @override
//  _JDPlayerState createState() => _JDPlayerState();
//}
//
//class _JDPlayerState extends State<JDPlayer> {
//
//  VideoPlayerController _controller;
//
//  @override
//  void initState() {
//    super.initState();
//
//    Function listener = () {
//      if (!mounted) {
//        return;
//      }
//      setState(() {});
//    };
//
//    _controller = VideoPlayerController.path('http://file.jinxianyun.com/testhaha.mp4', playerConfig: PlayerConfig())
//    //_controller = TencentPlayerController.asset('static/tencent1.mp4')
//    //_controller = TencentPlayerController.file('/storage/emulated/0/test.mp4')
//    //_controller = TencentPlayerController.network(null, playerConfig: {auth: {"appId": 1252463788, "fileId": '4564972819220421305'}})
//      ..initialize().then((_) {
//        setState(() {});
//      });
//    _controller.addListener(listener);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Center(
//      child: Container(
//        width: 200,
//        height: 200,
//        child: VideoPlayer(_controller),
//      ),
//    );
//  }
//}
