import 'package:flutter/material.dart';
import 'package:jd_core/jd_core.dart';

/// @author jd

class ErrorPage extends StatefulWidget {
  final String errorMessage;
  final FlutterErrorDetails details;

  ErrorPage(this.errorMessage, this.details);

  @override
  ErrorPageState createState() => ErrorPageState();
}

class ErrorPageState extends State<ErrorPage> {
  static List<Map<String, dynamic>> sErrorStack = <Map<String, dynamic>>[];
  static List<String> sErrorName = <String>[];

  final TextEditingController textEditingController = TextEditingController();

  addError(FlutterErrorDetails details) {
    try {
      var map = <String, dynamic>{};
      map['error'] = details.toString();
      addLogic(sErrorName, details.exception.runtimeType.toString());
      addLogic(sErrorStack, map);
    } catch (e) {
      print(e);
    }
  }

  addLogic(List list, data) {
    if (list.length > 20) {
      list.removeAt(0);
    }
    list.add(data);
  }

  @override
  Widget build(BuildContext context) {
    double width =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
    return Material(
      child: Container(
        color: Colors.red,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Text(
                      widget.errorMessage,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Image(
                            image:
                                AssetImage(JDAssetBundle.getIconPath('logo')),
                            width: 30.0,
                            height: 30.0),
                      ),
                      Text(
                        '哦，出错了',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {
                          String content = widget.errorMessage;
                          textEditingController.text = content;
                          print('这里做上传逻辑');
                        },
                        child: const Text(
                          'Report',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Back',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
