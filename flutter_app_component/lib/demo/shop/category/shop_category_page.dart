import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/demo/shop/category/model/category.dart';
import 'package:flutter_app_component/demo/shop/search/page/shop_search_page.dart';
import 'package:get/get.dart';
import 'package:jd_core/jd_core.dart';

import 'shop_category_vm.dart';

/// @author jd

class ShopCategoryPage extends StatefulWidget {
  @override
  _ShopCategoryPageState createState() => _ShopCategoryPageState();
}

class _ShopCategoryPageState extends State<ShopCategoryPage>
    with AutomaticKeepAliveClientMixin {
  final ShopCategoryVM _vm = Get.put(ShopCategoryVM());

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: SafeArea(
            child: Column(
              children: [
                _buildSearch(),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Obx(() => _buildSuggestions()),
                ),
              ],
            ),
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

  Widget _buildSuggestions() {
    ShopCategoryVM viewModel = _vm;
    return Row(
      children: <Widget>[
        _buildLeft(viewModel),
        Expanded(
          child: _buildRightMenu(viewModel),
        ),
      ],
    );
  }

  Widget _buildLeft(ShopCategoryVM viewModel) {
    List allMenuInfo = viewModel.list.value;
    return Container(
      width: 100,
      color: Colors.grey[100],
      child: ListView.builder(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: allMenuInfo.length,
        padding: const EdgeInsets.all(0),
        itemBuilder: (BuildContext context, int i) {
          return _buildRow(allMenuInfo[i], i);
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

  Widget _buildRow(Category category, int index) {
    final String text = category.name;
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

  Widget _buildRightMenu(ShopCategoryVM viewModel) {
    List allMenuInfo = viewModel.list.value;
    if (allMenuInfo.isEmpty) {
      return Container();
    }
    Category category = allMenuInfo[_currentIndex];
    List currentList = category.subCategory;
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
          SubCategory item = currentList[i];
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
                child: AutoSizeText(
                  item.name,
                  style: const TextStyle(fontSize: 14.0),
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ShopSearchPage();
              }));
              // _pushSaved(text, item['router'], item['page']);
            },
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
