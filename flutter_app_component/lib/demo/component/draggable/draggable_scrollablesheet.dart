import 'package:flutter/material.dart';
import 'package:jd_core/jd_core.dart';

/// @author jd

class DraggableScrollableSheetPage extends StatefulWidget {
  @override
  _DraggableScrollableSheetPageState createState() =>
      _DraggableScrollableSheetPageState();
}

class _DraggableScrollableSheetPageState
    extends State<DraggableScrollableSheetPage> {
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
                return _buildTopContent(scrollController);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTopContent(ScrollController scrollController) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          margin: const EdgeInsets.only(
            top: 40,
          ),
        ),
        Column(
          children: [
            Expanded(
              child: CustomScrollView(
                physics: const ClampingScrollPhysics(),
                controller: scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: _buildUserHeadWidget(),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      color: Colors.grey[200],
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: const Text(
                        '一周最热应用',
                        style: TextStyle(color: Colors.black, fontSize: 28),
                      ),
                    ),
                  ),
                  _buildOneDragList(),
                  SliverToBoxAdapter(
                    child: Container(
                      color: Colors.grey[200],
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: const Text(
                        '为你精选细挑',
                        style: TextStyle(color: Colors.black, fontSize: 28),
                      ),
                    ),
                  ),
                  _buildOneDragList(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUserHeadWidget() {
    return Container(
      height: 150,
      child: Stack(
        children: [
          Container(
            color: Colors.grey[200],
            margin: const EdgeInsets.only(top: 60),
          ),
          Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(
                    JDAssetBundle.getImgPath('user_head_0'),
                    width: 80,
                    height: 80,
                  ),
                ),
                const Text(
                  '欢迎回来',
                  style: TextStyle(color: Colors.lightBlue, fontSize: 30),
                ),
                const Text(
                  '看看你都错过了哪些精彩内容',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOneDragList() {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(
                10,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  JDAssetBundle.getImgPath('user_head_${index % 5}'),
                ),
              ),
            );
          },
          childCount: 20,
        ),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 120,
        ));
  }
}
