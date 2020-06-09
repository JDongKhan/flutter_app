import 'package:flutter/material.dart';
import 'package:flutter_component/utils/jd_asset_bundle.dart';

/**
 *
 * @author jd
 *
 */

class JDRecommendListPage extends StatefulWidget {

  final String title = "jd_recommend_list_page";

  @override
  State createState() => _JDRecommendListPageState();
}

class _JDRecommendListPageState extends State<JDRecommendListPage> {
  List<Map<String,dynamic>> _items = <Map<String,dynamic>>[];

  @override
  void initState() {
    super.initState();
    for(int i = 0; i < 20; i++) {
      _items.add(<String,dynamic>{
        "icon" : "recommend_customer_icon",
        "title" : "【八年老店】工业设计/产品外观结构设计/机器人设计/样品设计'",
        "price" : i,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          itemCount: _items.length,
          shrinkWrap: true,
          itemBuilder: (context,index) {
            var itm =  _items[index];
            return Container(
              color: Color(0xEEEEEEEE),
              padding: EdgeInsets.all(10),
              child: Container(
                color: Colors.white,
                child: ListTile(
                    leading: Image.asset(JDAssetBundle.getImgPath(itm['icon'].toString())),
                    title: Text(itm['title'].toString()),
                    subtitle: Text('￥${itm['price']}',style: TextStyle(color: Colors.red),)
                ),
              ),
            );
          }),
    );
  }
}