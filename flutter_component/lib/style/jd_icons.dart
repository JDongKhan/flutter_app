import 'package:flutter/material.dart';


class JDIcons {

}

final Map<String,IconData> iconsMap = <String,IconData>{
  'accessibility' : Icons.accessibility,
  'airport_shuttle' : Icons.airport_shuttle,
  'assessment' : Icons.assessment,
  'assignment' : Icons.assignment,
  'assignment_ind' : Icons.assignment_ind,
  'book' : Icons.book,
  'branding_watermark' : Icons.branding_watermark,
  'broken_image' : Icons.broken_image,
};

IconData mappingForKey(String key) => iconsMap[key];
