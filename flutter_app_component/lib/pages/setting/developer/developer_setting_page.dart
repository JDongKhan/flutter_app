import 'package:flutter/material.dart';
import 'package:jd_core/jd_core.dart';
import 'package:provider/provider.dart';

/// @author jd

class DeveloperSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    JDTheme theme = context.watch<JDTheme>();
    return Scaffold(
      appBar: myAppBar(
        title: Text('开发者设置'),
      ),
      body: Column(
        children: [
          _buildItemWidget(
            '性能监控',
            theme.showPerformanceOverlay,
            (value) {
              theme.switchPerformanceOverlay(value);
            },
          ),
          _buildItemWidget(
            '检查缓存图片情况',
            theme.checkerboardRasterCacheImages,
            (value) {
              theme.switchCheckerboardRasterCacheImages(value);
            },
          ),
          _buildItemWidget(
            '检查不必要的saveLayer',
            theme.checkerboardOffscreenLayers,
            (value) {
              theme.switchCheckerboardOffscreenLayers(value);
            },
          ),
          _buildItemWidget(
            '显示边界布局',
            theme.debugPaintSizeEnabled,
            (value) {
              theme.switchDebugPaintSizeEnabled(value);
            },
          ),
          _buildItemWidget(
            '点击效果',
            theme.debugPaintPointersEnabled,
            (value) {
              theme.switchDebugPaintPointersEnabled(value);
            },
          ),
          _buildItemWidget(
            '显示边界',
            theme.debugPaintLayerBordersEnabled,
            (value) {
              theme.switchDebugPaintLayerBordersEnabled(value);
            },
          ),
          _buildItemWidget(
            '重绘时周边显示旋转色',
            theme.debugRepaintRainbowEnabled,
            (value) {
              theme.switchDebugRepaintRainbowEnabled(value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildItemWidget(
      String title, bool value, ValueChanged<bool> changed) {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Text(title),
        const SizedBox(
          width: 20,
        ),
        Switch(
            value: value,
            onChanged: (value) {
              if (changed != null) {
                changed(value);
              }
            }),
      ],
    );
  }
}
