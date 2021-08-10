import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */

class ConstrainedBoxPage extends StatefulWidget {
  final String title = "constrainedbox";

  @override
  State createState() => _ConstrainedBoxPageState();
}

class _ConstrainedBoxPageState extends State<ConstrainedBoxPage> {
  Widget redBox = DecoratedBox(
    decoration: BoxDecoration(color: Colors.red),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: const <Widget>[
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(Colors.white70),
              ),
            ),
            UnconstrainedBox(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation(Colors.white70),
                ),
              ),
            )
          ],
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              ConstrainedBox(
                constraints: const BoxConstraints(
                    minWidth: double.infinity, //宽度尽可能大
                    minHeight: 50.0 //最小高度为50像素
                    ),
                child: Container(height: 5.0, child: redBox),
              ),

              const SizedBox(
                height: 20,
              ),

              //有多重限制时，对于minWidth和minHeight来说，是取父子中相应数值较大的。实际上，只有这样才能保证父限制与子限制不冲突
              ConstrainedBox(
                  constraints:
                      const BoxConstraints(minWidth: 60.0, minHeight: 60.0), //父
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                        minWidth: 90.0, minHeight: 20.0), //子
                    child: redBox,
                  )),

              ConstrainedBox(
                  constraints: const BoxConstraints(
                      minWidth: 60.0, minHeight: 100.0), //父
                  child: UnconstrainedBox(
                    //“去除”父级限制
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                          minWidth: 90.0, minHeight: 20.0), //子
                      child: redBox,
                    ),
                  ))
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
