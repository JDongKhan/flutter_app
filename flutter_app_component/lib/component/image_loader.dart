import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jd_core/jd_core.dart';

/// @author jd
class ImageLoader extends StatelessWidget {
  const ImageLoader({
    Key key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.alignment = Alignment.center,
  }) : super(key: key);

  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      progressIndicatorBuilder:
          (BuildContext context, String url, DownloadProgress progress) =>
              LinearProgressIndicator(
        value: progress.progress,
      ),
      placeholder: (BuildContext context, String url) =>
          Image.asset(JDAssetBundle.getImgPath('default_image')),
      errorWidget: (BuildContext context, String url, dynamic error) =>
          Image.asset(JDAssetBundle.getImgPath('error_image')),
    );
  }
}
