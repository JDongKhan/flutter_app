import 'package:flex_grid/flex_grid.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

import 'flex_grid_source.dart';

/// @author jd

class FlexGridDemoPage extends StatefulWidget {
  @override
  _FlexGridDemoPageState createState() => _FlexGridDemoPageState();
}

class _FlexGridDemoPageState extends State<FlexGridDemoPage> {
  FlexGridSource source = FlexGridSource();

  @override
  Widget build(BuildContext context) {
    final MyCellStyle style =
        MyCellStyle(frozenedColumnsCount: 1, frozenedRowsCount: 1);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FlexGrid'),
      ),
      body: FlexGrid<GridRow>(
        frozenedColumnsCount: 1,
        frozenedRowsCount: 0,
        cellStyle: style,
        headerStyle: style,
        columnsCount: GridRow.cloumnNames.length,
        outerHorizontalSyncController: null,
        physics: const AlwaysScrollableClampingScrollPhysics(),
        cellBuilder: (BuildContext context, GridRow data, int row, int column) {
          return Text(column == 0 ? '$row' : data.columns[column].toString());
        },
        headerBuilder: (BuildContext context, int index) {
          return Text(GridRow.cloumnNames[index]);
        },
        source: source,
      ),
    );
  }
}

class MyCellStyle extends CellStyle {
  MyCellStyle({
    Alignment alignment = Alignment.center,
    EdgeInsetsGeometry padding,
    Color color,
    Decoration decoration,
    double height = 60,
    double width = 100,
    this.frozenedColumnsCount = 0,
    this.frozenedRowsCount = 0,
  }) : super(
          alignment: alignment,
          padding: padding,
          color: color,
          decoration: decoration,
          height: height,
          width: width,
        );

  final int frozenedColumnsCount;
  final int frozenedRowsCount;
  @override
  Widget apply(
    Widget child,
    int row,
    int column, {
    CellStyleType type = CellStyleType.cell,
  }) {
    Color backgroundColor = Colors.white;

    switch (type) {
      case CellStyleType.header:
        backgroundColor =
            column < frozenedColumnsCount ? Colors.yellow : Colors.lightGreen;
        break;
      case CellStyleType.cell:
        backgroundColor = row < frozenedRowsCount
            ? Colors.purple
            : (column < frozenedColumnsCount ? Colors.yellow : Colors.white);
        break;

      default:
        backgroundColor = Colors.white;
    }

    return Container(
      child: child,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.5),
          ),
          right: BorderSide(
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
      ),
      alignment: alignment,
      height: height,
      width: width,
    );
  }
}
