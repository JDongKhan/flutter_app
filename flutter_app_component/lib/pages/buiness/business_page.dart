import 'package:flutter/material.dart';
import 'package:flutter_app_component/component/image_loader.dart';
import 'package:flutter_app_component/models/image_model.dart';
import 'package:flutter_app_component/service/request.dart';
import 'package:jd_core/style/jd_push_animation.dart';
import 'package:jd_core/utils/jd_asset_bundle.dart';
import 'package:jd_core/widget//async/jd_futurebuilder.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

/// @author jd

class BusinessPage extends StatefulWidget {
  const BusinessPage(this.source);

  final String source;

  @override
  State createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage>
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
        return WaterfallFlow.builder(
          padding: const EdgeInsets.all(1.0),
          itemCount: list.length,
          gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
            lastChildLayoutTypeBuilder: (int index) => index == list.length
                ? LastChildLayoutType.foot
                : LastChildLayoutType.none,
          ),
          itemBuilder: (BuildContext context, int index) =>
              _buildImageItem(list.elementAt(index), index),
        );
      },
    );
  }

  Widget _buildImageItem(JDImage images, int index) {
    final bool isNetwork =
        images?.url?.startsWith('http') || images?.url?.startsWith('https');

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          JDFadeRouter<dynamic>(
            child: ImagePreViewWidget(
              url: images.url,
              source: widget.source,
              index: index,
            ),
          ),
        );
      },
      child: Hero(
        tag: '${widget.source}-$index-${images.url}',
        // child: CachedNetworkImage(imageUrl: images.url),
        child: isNetwork
            ? ImageLoader(
                imageUrl: images.url,
              )
            : Image.asset(
                JDAssetBundle.getImgPath(images.url),
              ),
      ),
    );
  }
}

class ImagePreViewWidget extends StatelessWidget {
  const ImagePreViewWidget({
    Key key,
    @required this.url,
    @required this.source,
    this.index,
  }) : super(key: key);

  final String url;
  final String source;
  final int index;

  @override
  Widget build(BuildContext context) {
    final bool isNetwork = url?.startsWith('http') || url?.startsWith('https');
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Hero(
          tag: '$source-$index-$url',
          child: isNetwork
              ? ImageLoader(
                  imageUrl: url,
                  // fit: BoxFit.fill,
                )
              : Image.asset(
                  JDAssetBundle.getImgPath(url),
                  // fit: BoxFit.fill,
                ),
        ),
      ),
    );
  }
}
