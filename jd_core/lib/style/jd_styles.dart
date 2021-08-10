import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'jd_colors.dart';
import 'jd_dimens.dart';

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
  border: Border(
    bottom: BorderSide(width: 0.33, color: JDColors.divider),
  ),
);

//统一app style
AppBar myAppBar({
  Key key,
  Widget leading,
  bool automaticallyImplyLeading = true,
  Widget title,
  double elevation = 1,
  List<Widget> actions,
  PreferredSizeWidget bottom,
  Color backgroundColor,
  Color foregroundColor,
  Brightness brightness,
  IconThemeData iconTheme,
  IconThemeData actionsIconTheme,
  TextTheme textTheme,
  bool primary = true,
  bool centerTitle,
  double titleSpacing,
  double leadingWidth,
  SystemUiOverlayStyle systemOverlayStyle,
}) {
  return AppBar(
    key: key,
    leading: leading,
    title: title,
    actions: actions,
    bottom: bottom,
    elevation: elevation,
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    brightness: brightness,
    iconTheme: iconTheme,
    actionsIconTheme: actionsIconTheme,
    textTheme: textTheme,
    primary: primary,
    centerTitle: centerTitle,
    titleSpacing: titleSpacing,
    leadingWidth: leadingWidth,
    systemOverlayStyle: systemOverlayStyle,
  );
}
