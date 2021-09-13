import 'package:flutter/material.dart';
import 'package:jd_core/widget/sliverpersistentheaderdelegate/jd_sliverpersistentheaderdelegate.dart';

/// @author jd

class CustomScrollViewStudy extends StatefulWidget {
  @override
  _CustomScrollViewStudyState createState() => _CustomScrollViewStudyState();
}

class _CustomScrollViewStudyState extends State<CustomScrollViewStudy> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              alignment: Alignment.center,
              child: const Text('Header-0:100高度'),
              height: 100,
              color: Colors.yellow.withOpacity(0.4),
            ),
          ),
          _buildPersistentHeader(
              height: 100,
              child: Container(
                child: const Text('Header-1:Pinned 100高度'),
                alignment: Alignment.center,
                color: Colors.red.withOpacity(0.4),
              )),
          SliverToBoxAdapter(
            child: Container(
              alignment: Alignment.center,
              child: const Text('Header-2:100高度'),
              height: 100,
              color: Colors.yellow.withOpacity(0.4),
            ),
          ),
          SliverFillRemaining(
            child: Column(
              children: List.generate(
                100,
                (index) => Container(
                  alignment: Alignment.center,
                  child: Text('body:里面的内容:$index,高度100'),
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.4),
                    border: Border.all(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///tabbar
  Widget _buildPersistentHeader({Widget child, double height = 60}) =>
      SliverPersistentHeader(
        pinned: true,
        delegate: JDSliverPersistentHeaderDelegate(
          height,
          height,
          child,
        ),
      );
}
