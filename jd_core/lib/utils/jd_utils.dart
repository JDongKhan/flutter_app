library utils;

import 'dart:ui';

import 'package:flutter/material.dart';

import 'jd_object_utils.dart';
import 'jd_regex_utils.dart';
import 'jd_timeline_utils.dart';

export 'jd_asset_bundle.dart';
export 'jd_navigation_util.dart';
export 'jd_screen_utils.dart';
export 'jd_toast_utils.dart';

/// @author jd
class JDUtils {
  static Color nameToColor(String name) {
    // assert(name.length > 1);
    final int hash = name.hashCode & 0xffff;
    final double hue = (360.0 * hash / (1 << 15)) % 360.0;
    return HSVColor.fromAHSV(1.0, hue, 0.4, 0.90).toColor();
  }

  static String getTimeLine(BuildContext context, int timeMillis) {
//    LogUtil.e("countryCode: " +
//        Localizations.localeOf(context).countryCode +
//        "   languageCode: " +
//        Localizations.localeOf(context).languageCode);
    return TimelineUtil.format(timeMillis,
        locale: Localizations.localeOf(context).languageCode,
        dayFormat: DayFormat.Common);
  }

  static double getTitleFontSize(String title) {
    if (ObjectUtils.isEmpty(title) || title.length < 10) {
      return 18.0;
    }
    int count = 0;
    List<String> list = title.split("");
    for (int i = 0, length = list.length; i < length; i++) {
      String ss = list[i];
      if (RegexUtil.isZh(ss)) {
        count++;
      }
    }

    return (count >= 10 || title.length > 16) ? 14.0 : 18.0;
  }

  // static int getLoadStatus(bool hasError, List data) {
  //   if (hasError) return LoadStatus.fail;
  //   if (data == null) {
  //     return LoadStatus.loading;
  //   } else if (data.isEmpty) {
  //     return LoadStatus.empty;
  //   } else {
  //     return LoadStatus.success;
  //   }
  // }
}
