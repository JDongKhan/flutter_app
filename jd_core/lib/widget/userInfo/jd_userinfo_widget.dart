import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// @deprecated('will be delete')
class JDUserInfoWidget extends StatelessWidget {
  const JDUserInfoWidget({
    Key key,
    this.userIcon,
    this.title,
    this.flag,
    this.rightWidget,
  }) : super(key: key);

  final Image userIcon;
  final String title;
  final String flag;
  final Widget rightWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: userIcon,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    flag,
                    style: const TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (rightWidget != null) rightWidget,
      ],
    );
  }
}
