import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// @author jd

class HomeAddInfoPage extends StatefulWidget {
  @override
  _HomeAddInfoPageState createState() => _HomeAddInfoPageState();
}

class _HomeAddInfoPageState extends State<HomeAddInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('发布需求'),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              _buildInfoNameWidget(),
              _buildContentWidget(),
              _buildImagesWidget(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 40,
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
              child: TextButton(
                onPressed: () {},
                child: const Text('发布'),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoNameWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: const TextField(
        decoration: InputDecoration(
          labelText: '需求标题',
          hintText: '发布您的需求标题',
        ),
      ),
    );
  }

  Widget _buildContentWidget() {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: const TextField(
        maxLines: 8,
        decoration: InputDecoration(hintText: '需求内容（技术要求）：请详细描述你的内容'),
      ),
    );
  }

  Widget _buildImagesWidget() {
    List imags = [];
    Widget gridView = GridView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      children: [
        Icon(Icons.add),
      ],
    );

    return Container(
      margin: const EdgeInsets.only(left: 10, top: 20, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: const TextSpan(
                text: '添加图片',
                style: TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(
                    text: '(长按删除)',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ]),
          ),
          gridView,
        ],
      ),
    );
  }
}
