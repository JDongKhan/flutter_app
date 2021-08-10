import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_component/models/image_model.dart';
import 'package:flutter_app_component/service/request.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jd_core/style/jd_push_animation.dart';
import 'package:jd_core/widget//async/jd_futurebuilder.dart';

/// @author jd

class JDBusinessPage extends StatefulWidget {
  const JDBusinessPage(this.source);

  final String source;

  @override
  State createState() => _JDBusinessPageState();
}

class _JDBusinessPageState extends State<JDBusinessPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return JDFutureBuilder<List<JDImage>>(
      future: Request.imageList(),
      onError: () {
        setState(() {});
      },
      complete: (BuildContext context, dynamic obj) {
        final List<JDImage> list = obj as List<JDImage>;
        return StaggeredGridView.countBuilder(
          padding: const EdgeInsets.all(1.0),
          crossAxisCount:
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? 2
                  : 4,
          mainAxisSpacing: 1.0,
          itemCount: list.length,
          crossAxisSpacing: 1.0,
          itemBuilder: (BuildContext context, int index) =>
              _buildImageItem(list.elementAt(index), index),
          staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
        );
      },
    );
  }

  Widget _buildImageItem(JDImage images, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          JDNoAnimRouter<dynamic>(
            child: ImagePreViewWidget(
              url: images.url,
              source: widget.source,
            ),
          ),
        );
      },
      child: Hero(
        tag: '${widget.source}-${index}-${images.url}',
        // child: CachedNetworkImage(imageUrl: images.url),
        child: Image.network(images.url),
      ),
    );
  }
}

class ImagePreViewWidget extends StatelessWidget {
  const ImagePreViewWidget({
    Key key,
    @required this.url,
    @required this.source,
  }) : super(key: key);

  final String url;
  final String source;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Hero(
                  tag: '${source}-${url}',
                  child: CachedNetworkImage(imageUrl: url),
                ))));
  }
}
