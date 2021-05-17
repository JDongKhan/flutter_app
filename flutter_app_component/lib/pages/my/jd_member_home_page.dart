import 'package:flutter/material.dart';

/// @author jd

class JDMemberHomePage extends StatefulWidget {
  @override
  _JDMemberHomePageState createState() => _JDMemberHomePageState();
}

class _JDMemberHomePageState extends State<JDMemberHomePage> {
  Widget _buildBackHomeList() {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(title: Text('个人信息 $index'));
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
        itemCount: 100);
  }

  Widget _buildBackHome() {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 4,
          child: Container(
            height: 200,
            color: Colors.red,
            alignment: Alignment.center,
            child: const Text('个人介绍'),
          ),
        ),
        Flexible(
          flex: 12,
          child: _buildBackHomeList(),
        )
      ],
    );
  }

  Widget _buildDragList(ScrollController scrollController) {
    return ListView.builder(
      controller: scrollController,
      itemCount: 100,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(title: Text('评论 $index'));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人主页'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            alignment: Alignment.topLeft,
            child: FractionallySizedBox(
              heightFactor: .8,
              child: _buildBackHome(),
            ),
          ),
          NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              print('#####################');
              print('minExtent = ${notification.minExtent}');
              print('maxExtent = ${notification.maxExtent}');
              print('initialExtent = ${notification.initialExtent}');
              print('extent = ${notification.extent}');
              return true;
            },
            child: DraggableScrollableSheet(
              expand: true,
              initialChildSize: 0.2,
              minChildSize: 0.2,
              maxChildSize: 0.8,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  color: Colors.blue[100],
                  child: _buildDragList(scrollController),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
