import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/component/customscrollview/custom_sliver_widget.dart';

/// @author jd
class CustomRefreshPage extends StatefulWidget {
  @override
  _CustomRefreshPageState createState() => _CustomRefreshPageState();
}

class _CustomRefreshPageState extends State<CustomRefreshPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSliverWidget(
            child: Container(
              color: Colors.red,
              height: 100,
              child: const Center(
                child: Text('Custom Refresh Sliver'),
              ),
            ),
          ),
          _buildListView(),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return ListTile(title: Text('test : ${index}'));
      }, childCount: 10),
    );
  }
}
