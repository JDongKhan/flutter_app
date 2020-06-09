import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_component/models/image_model.dart';
import 'package:flutter_component/network/jd_request.dart';
import 'package:flutter_component/widget/async/jd_futurebuilder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/**
 *
 * @author jd
 *
 */

class JDBusinessPage extends StatefulWidget {

  final String title = "业务";

  @override
  State createState() => _JDBusinessPageState();
}

class _JDBusinessPageState extends State<JDBusinessPage> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return  JDFutureBuilder<List<JDImage>>(
      future: JDRequest.imageList(),
      onError: () {
        setState(() {
        });
      },
      complete: (BuildContext context, dynamic obj) {
        List<JDImage> list = obj as List<JDImage>;
        return StaggeredGridView.countBuilder(
          padding: const EdgeInsets.all(1.0),
          crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4,
          mainAxisSpacing: 1.0,
          itemCount: list.length,
          crossAxisSpacing: 1.0,
          itemBuilder: (BuildContext context, int index) => _buildImageItem(list.elementAt(index)),
          staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
        );
      },
    ) ;
  }

  Widget _buildImageItem(JDImage images) {
    return  InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => ImagePreViewWidget(url: images.url),
            ));
      },
      child: Hero(
        tag: images.url,
        child: CachedNetworkImage(imageUrl: images.url),
      ),
    );
  }

}

class ImagePreViewWidget extends StatelessWidget {
  final String url;

  const ImagePreViewWidget({
    Key key,
    @required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  },
                child: Hero(
                  tag: url,
                  child: CachedNetworkImage(imageUrl:url),
                )
            )
        )
    );
  }
}