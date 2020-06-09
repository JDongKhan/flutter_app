import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */

class JDIcons {

   static final iconsMap = {
    "accessibility" : Icons.accessibility,
    "airport_shuttle" : Icons.airport_shuttle,
    "airport_shuttle" : Icons.airport_shuttle,
    "assessment" : Icons.assessment,
    "assignment" : Icons.assignment,
    "assignment_ind" : Icons.assignment_ind,
    "book" : Icons.book,
    "branding_watermark" : Icons.branding_watermark,
    "broken_image" : Icons.broken_image,
  };

  static IconData mappingForKey(String key) => iconsMap[key];

}
