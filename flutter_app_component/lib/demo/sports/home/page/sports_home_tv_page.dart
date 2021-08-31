import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/sports/home/vm/sports_home_tv_vm.dart';
import 'package:flutter_app_component/demo/sports/home/widget/sports_home_tv_item.dart';
import 'package:flutter_app_component/demo/sports/home/widget/timer_widget.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jd_core/jd_core.dart';
import 'package:jd_core/view_model/widget/provider_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// @author jd

class SportsHomeTvPage extends StatefulWidget {
  @override
  _SportsHomeTvPageState createState() => _SportsHomeTvPageState();
}

class _SportsHomeTvPageState extends State<SportsHomeTvPage> {
  void _onLoading() {}

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<SportsHomeTVVm>(
      model: SportsHomeTVVm(),
      builder: (BuildContext context, SportsHomeTVVm vm) {
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          footer: JDCustomFooter(),
          header: BezierHeader(
              child: const Center(child: Icon(Icons.wallet_giftcard))),
          controller: vm.refreshController,
          onLoading: vm.loadMore,
          onRefresh: vm.refresh,
          child: CustomScrollView(
            slivers: [
              _buildSwiperWidget(),
              _buildTextAdWidget(vm),
              _buildGuessLikeWidget(vm),
              _recentlyUpdateTitleWidget(),
              _recentlyUpdateGridView(vm),
            ],
          ),
        );
      },
    );
  }

  ///Swiper
  Widget _buildSwiperWidget() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width,
        height: 150,
        child: Swiper(
          itemCount: 5,
          autoplay: true,
          viewportFraction: 0.95,
          pagination: const SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                  activeColor: Colors.red, color: Colors.green)),
          itemBuilder: (BuildContext context, int index) {
            if (index % 2 == 0) {
              return Image.asset(
                JDAssetBundle.getImgPath('bg_0', format: 'jpg'),
                fit: BoxFit.fill,
              );
            }
            return Image.asset(
              JDAssetBundle.getImgPath('bg_1', format: 'jpg'),
              fit: BoxFit.fill,
            );
          },
        ),
      ),
    );
  }

  ///文本广告
  Widget _buildTextAdWidget(SportsHomeTVVm vm) {
    return SliverToBoxAdapter(
      child: Container(
        height: 40,
        color: Colors.grey[100],
        padding: const EdgeInsets.only(left: 10, right: 10),
        alignment: Alignment.centerLeft,
        child: TimerWidget(
          maxIndex: 2,
          builder: (BuildContext context, int index) {
            return Text(
              vm.textAdList[index],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            );
          },
        ),
      ),
    );
  }

  Widget _buildGuessLikeWidget(SportsHomeTVVm vm) {
    return SliverToBoxAdapter(
      child: Container(
        height: 170,
        child: ListView.builder(
          itemCount: vm.likeList.length,
          itemExtent: 200,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            Map video = vm.likeList[index];
            return SportsHomeTVItem(video);
          },
        ),
      ),
    );
  }

  Widget _recentlyUpdateTitleWidget() {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
        child: Text(
          '最近更新',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }

  Widget _recentlyUpdateGridView(SportsHomeTVVm vm) {
    return SliverGrid(
      //Grid
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //Grid按两列显示
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 1.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          Map video = vm.likeList[index];
          //创建子widget
          return SportsHomeTVItem(video);
        },
        childCount: 4,
      ),
    );
  }
}
