import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/demo/renderbox/comp/jd_renderconstrainedbox.dart';
import 'package:flutter_app_component/demo/renderbox/comp/jd_rendershiftedbox.dart';

/*
* 1、当我们使用这种方式自定义控件的时候，至少需要自定义一个widget和一个renderobject.通常，我们的Widget可以继承下面三种类
* SingleChildRenderObjectWidget : RenderObject只有一个child
* MultiChildRenderObjectWidget : 可以有多个child
* LeafRenderObjectWidget : RenderObject是一个叶子节点，没有child
*
* 2、而我们自定义的RenderObject通常可以从RenderShiftBox或者RenderProxyBox及其子类派生。
* RenderShiftBox用于当前容器有跟大小相关的属性
* RenderProxyBox用于当前容器没有跟大小相关的属性，size由子类觉得。
*
* 当然建议使用flutter推荐的两个控件自定义布局
* CustomSingleChildLayout 处理单个child的布局
* CustomMultiChildLayout 处理多个child的布局
*/

class JDRenderShiftedBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RenderBoxDemo"),
      ),
      body: _buildRenderConstrainedBox(),
    );
  }

  Widget _buildRenderShiftedBox() {
    return JDAlignWidget(
      alignment: Alignment.centerRight,
      child: Container(
        width: 100,
        height: 100,
        color: Colors.red,
      ),
    );
  }

  Widget _buildRenderConstrainedBox() {
    return JDTouchHighlightWidget(
      child: const Center(
        child: Text("HelloWorld"),
      ),
    );
  }
}
