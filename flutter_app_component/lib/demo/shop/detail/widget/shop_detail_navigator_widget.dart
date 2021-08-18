import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jd_core/jd_core.dart';

/// @author jd

class ShopDetailNavigatorController extends ChangeNotifier {
  ValueChanged<int> onClickTabItem;

  int _tabIndex = 0;
  set tabIndex(value) {
    if (value != _tabIndex) {
      _tabIndex = value;
      notifyListeners();
    }
  }

  int get tabIndex => _tabIndex;

  double _alpha = 0.0;
  set alpha(value) {
    if (value != _alpha) {
      _alpha = value;
      notifyListeners();
    }
  }

  double get alpha => _alpha;
}

class ShopDetailNavigatorWidget extends StatefulWidget {
  const ShopDetailNavigatorWidget({
    @required this.navigatorController,
  });

  final ShopDetailNavigatorController navigatorController;

  @override
  _ShopDetailNavigatorWidgetState createState() =>
      _ShopDetailNavigatorWidgetState();
}

class _ShopDetailNavigatorWidgetState extends State<ShopDetailNavigatorWidget>
    with TickerProviderStateMixin {
  TabController _tabController;
  final Color _backgroundColor = Colors.white;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    widget.navigatorController.addListener(() {
      setState(() {
        _tabController.index = widget.navigatorController.tabIndex;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('刷新了一下子');
    return Stack(
      children: [
        Opacity(
          opacity: 1 - widget.navigatorController.alpha,
          child: Container(
            child: SafeArea(
              child: Container(
                height: 44,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const Spacer(),
                    IconButton(
                        icon: const Icon(
                          Icons.upload_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {}),
                  ],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: widget.navigatorController.alpha,
          child: Container(
            color: _backgroundColor,
            child: SafeArea(
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[200],
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Expanded(
                      child: Container(
                        child: Center(
                          child: TabBar(
                            onTap: _tap,
                            controller: _tabController,
                            tabs: const <Widget>[
                              Text('商品'),
                              Text('评价'),
                              Text('详情'),
                            ],
                            unselectedLabelColor: Colors.grey,
                            unselectedLabelStyle: TextStyle(
                              fontSize: jd_getSp(28),
                              fontWeight: FontWeight.w500,
                            ),
                            labelColor: Colors.black,
                            indicatorColor: Colors.blue,
                            labelStyle: TextStyle(
                              fontSize: jd_getSp(30),
                              fontWeight: FontWeight.w500,
                            ),
                            isScrollable: true,
                            indicatorSize: TabBarIndicatorSize.label,
                            labelPadding:
                                const EdgeInsets.only(left: 10, right: 10),
                            // indicatorPadding: EdgeInsets.only(top: 1),
                            indicatorWeight: 4,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.upload_outlined,
                          color: Colors.black,
                        ),
                        onPressed: () {}),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _tap(int index) {
    print('点击:$index');
    widget.navigatorController.tabIndex = _tabController.index;
    if (widget.navigatorController.onClickTabItem != null) {
      widget.navigatorController.onClickTabItem(index);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
