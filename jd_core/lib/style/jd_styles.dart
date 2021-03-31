import 'package:flutter/widgets.dart';
import 'jd_dimens.dart';
import 'jd_colors.dart';

const TextStyle list_title_style = TextStyle(
  fontSize: JDDimens.font_sp14,
  color: JDColors.text_dark,
  fontWeight: FontWeight.bold,
);

const TextStyle list_content_style = TextStyle(
  fontSize: JDDimens.font_sp12,
  color: JDColors.text_normal,
);

const TextStyle list_extra_style = TextStyle(
  fontSize: JDDimens.font_sp12,
  color: JDColors.text_gray,
);

const Decoration bottom_decoration = BoxDecoration(
    border: Border(bottom: BorderSide(width: 0.33, color: JDColors.divider))
);


