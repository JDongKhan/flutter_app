import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jd_core/jd_core.dart';

/// @author jd

class ShopDetailNavigatorController extends ChangeNotifier {
  double alpha = 0.0;
  int tabIndex = 0;
  TabController _tabController;
  void changeAlpha(double alpha) {
    if (alpha != this.alpha) {
      this.alpha = alpha;
      notifyListeners();
    }
  }

  void changeTabIndex(int tabIndex) {
    this.tabIndex = tabIndex;
    _tabController.index = tabIndex;
  }
}

class ShopDetailNavigatorWidget extends StatefulWidget {
  final ShopDetailNavigatorController controller;
  ShopDetailNavigatorWidget({
    @required this.controller,
  });
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
    widget.controller.addListener(() {
      setState(() {});
    });
    widget.controller._tabController = _tabController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('刷新了一下子');
    return Stack(
      children: [
        Opacity(
          opacity: 1 - widget.controller.alpha,
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
          opacity: widget.controller.alpha,
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
}
