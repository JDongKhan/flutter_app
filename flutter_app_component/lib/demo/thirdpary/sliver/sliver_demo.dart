import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

/// @author jd
class SliverPageDemo extends StatefulWidget {
  @override
  _SliverPageDemoState createState() => _SliverPageDemoState();
}

class _SliverPageDemoState extends State<SliverPageDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('sliver tools'),
      ),
      body: CustomScrollView(
        slivers: [
          Section(
            title: const Text(
              'SliverStack',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            content: SliverStack(
              children: <Widget>[
                SliverPositioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 8,
                          color: Colors.black26,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                _buildList(),
              ],
            ),
          ),
          Section(
            title: const Text(
              'SliverClip',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            content: SliverClip(
              clipOverlap: false,
              child: _buildList(),
            ),
          ),
          Section(
            title: const Text(
              'SliverCrossAxisConstrained',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            content: SliverCrossAxisConstrained(
              maxCrossAxisExtent: 700,
              child: _buildList(),
            ),
          ),
          Section(
            title: const Text(
              'SliverCrossAxisPadded',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            content: SliverCrossAxisPadded(
              paddingStart: 24,
              paddingEnd: 24,
              textDirection: TextDirection.ltr,
              child: _buildList(),
            ),
          ),
        ],
      ),
    );
  }
}

class Section extends StatelessWidget {
  const Section({
    this.infinite = false,
    @required this.title,
    @required this.content,
  })  : assert(title != null, 'title can not null '),
        assert(content != null, 'content can not null ');
  final bool infinite;
  final Widget title;
  final Widget content;
  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      pushPinnedChildren: true,
      children: <Widget>[
        SliverPinnedHeader(
          child: Container(
            color: Colors.grey[100],
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
            child: title,
          ),
        ),
        // SliverPersistentHeader(
        //   pinned: true,
        //   delegate: JDSliverPersistentHeaderDelegate(
        //     40,
        //     40,
        //     Container(
        //       color: Colors.grey[100],
        //       alignment: Alignment.centerLeft,
        //       padding: const EdgeInsets.only(left: 10),
        //       child: title,
        //     ),
        //   ),
        // ),
        if (infinite)
          SliverAnimatedPaintExtent(
            duration: const Duration(milliseconds: 300),
            child: content,
          )
        else
          content,
      ],
    );
  }
}

Widget _buildList() {
  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (context, index) {
        return Container(
          color: Colors.blue[100],
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          child: ListTile(
            title: Text('test : ${index}'),
          ),
        );
      },
      childCount: 10,
    ),
  );
}
