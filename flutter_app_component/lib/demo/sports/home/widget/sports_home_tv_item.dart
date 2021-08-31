import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jd_core/utils/jd_asset_bundle.dart';

/// @author jd
class SportsHomeTVItem extends StatelessWidget {
  const SportsHomeTVItem(this.video);
  final Map video;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              JDAssetBundle.getImgPath(video['img'], format: 'png'),
              fit: BoxFit.fitHeight,
              width: 200,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, top: 10),
            child: Text(
              video['title'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, top: 5),
            child: Text(
              video['remark'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
