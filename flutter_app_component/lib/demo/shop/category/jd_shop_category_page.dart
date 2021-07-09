import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/demo/shop/search/jd_shop_search_page.dart';
import 'package:jd_core/jd_core.dart';
import 'package:jd_core/view_model/widget/provider_widget.dart';

import 'jd_shop_category_view_model.dart';

/// @author jd

class JDShopCategoryPage extends StatefulWidget {
  @override
  _JDShopCategoryPageState createState() => _JDShopCategoryPageState();
}

class _JDShopCategoryPageState extends State<JDShopCategoryPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              _buildSearch(),
              Expanded(
                child: ProviderWidget<JDShopCategoryViewModel>(
                    model: JDShopCategoryViewModel(),
                    builder: (context, model) {
                      return _buildSuggestions(model);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return JDSearchBar(
      color: Colors.grey[100],
    );
  }

  Widget _buildSuggestions(JDShopCategoryViewModel viewModel) {
    return Row(
      children: <Widget>[
        _buildLeft(viewModel),
        Expanded(
          child: _buildRightMenu(viewModel),
        ),
      ],
    );
  }

  Widget _buildLeft(JDShopCategoryViewModel viewModel) {
    List allMenuInfo = viewModel.list;
    //下划线widget预定义以供复用。
    Widget divider1 = Divider(
      height: 1,
      color: Colors.grey[100],
    );
    return Container(
      width: 100,
      color: Colors.grey[100],
      child: ListView.separated(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: allMenuInfo.length,
        padding: const EdgeInsets.all(0),
        itemBuilder: (BuildContext context, int i) {
          return _buildRow(allMenuInfo[i], i);
        },
        //分割器构造器
        separatorBuilder: (BuildContext context, int index) {
          return divider1;
        },
      ),
    );
  }

  _borderRadius(index) {
    if (index == _currentIndex + 1) {
      return const BorderRadius.only(topRight: Radius.circular(10));
    }
    if (index == _currentIndex - 1) {
      return const BorderRadius.only(bottomRight: Radius.circular(10));
    }
    return null;
  }

  Widget _buildRow(Map<String, dynamic> map, int index) {
    final String text = map['name'];
    return InkWell(
      child: Container(
        color: Colors.white,
        child: Container(
          alignment: Alignment.centerLeft,
          height: 40,
          decoration: BoxDecoration(
            color: index == _currentIndex ? Colors.white : Colors.grey[100],
            borderRadius: _borderRadius(index),
          ),
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.0,
              color: index == _currentIndex ? Colors.blue : Colors.black,
            ),
          ),
        ),
      ),
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  Widget _buildRightMenu(JDShopCategoryViewModel viewModel) {
    List allMenuInfo = viewModel.list;
    Map map = allMenuInfo[_currentIndex];
    List currentList = map['subs'];
    double width = (jd_screenWidth() - 100) / 3 - 10;
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: width, //每个宽100
          crossAxisSpacing: 10,
          mainAxisExtent: 50,
        ),
        itemCount: currentList.length,
        itemBuilder: (context, i) {
          String item = currentList[i];
          return GestureDetector(
            child: Container(
              alignment: Alignment.center,
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size(width, 40),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  side: BorderSide(
                    color: Colors.grey[300],
                  ),
                ),
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 14.0),
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return JDShopSearchPage();
              }));
              // _pushSaved(text, item['router'], item['page']);
            },
          );
        });
  }
}
