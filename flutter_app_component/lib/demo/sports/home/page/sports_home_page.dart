import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/sports/home/model/sports_content.dart';
import 'package:flutter_app_component/demo/sports/home/vm/sports_home_vm.dart';
import 'package:flutter_app_component/demo/sports/home/widget/sports_home_item.dart';
import 'package:jd_core/jd_core.dart';
import 'package:jd_core/view_model/widget/provider_widget.dart';

class SportsHomePage extends StatefulWidget {
  const SportsHomePage(this.title);

  final String title;

  @override
  _SportsHomePageState createState() => _SportsHomePageState();
}

class _SportsHomePageState extends State<SportsHomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearch(),
        Expanded(
          child: _buildContent(),
        ),
      ],
    );
  }

  Widget _buildSearch() {
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Expanded(
              child: JDSearchBar(
            height: 40,
          )),
          IconButton(
              icon: const Icon(
                Icons.airplay,
                size: 18,
                color: Colors.white,
              ),
              onPressed: () {}),
          IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                size: 18,
                color: Colors.white,
              ),
              onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return ProviderWidget(
        errorTextStyle: const TextStyle(
          color: Colors.black,
        ),
        builder: (BuildContext context, SportsHomeVm vm) {
          return ListView.separated(
            itemBuilder: (c, idx) {
              SportsContent content = vm.list[idx];
              if (content.flag == '1') {
                return SportsHomeItem1(content: content);
              }
              if (content.flag == '2') {
                return SportsHomeItem2(content: content);
              }
              if (content.flag == '3') {
                return SportsHomeItem3(content: content);
              }
              if (content.flag == '4') {
                return SportsHomeItem4(content: content);
              }

              if (content.flag == '5') {
                return SportsHomeItem5(content: content);
              }

              return SportsHomeItem(content: content);
            },
            separatorBuilder: (c, idx) {
              return const Divider();
            },
            itemCount: vm.list.length,
          );
        },
        model: SportsHomeVm());
  }

  @override
  bool get wantKeepAlive => true;
}
