import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

/**
 *
 * @author jd
 *
 */

class JDHomeSearchBarDelegate extends SearchDelegate<String> {
  var dataSource = [
    "哈哈哈哈哈呵呵呵呵嘻嘻嘻嘻嘻",
    "hahahahahahehehehehehxixixixix",
    "呵呵呵呵嘻嘻嘻嘻嘻哈哈哈哈哈"
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context,null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Card(
        color: Colors.redAccent,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
   return ListView.builder(
       itemCount: 3,
       itemBuilder: (BuildContext context,int index) => ListTile(
         title: InkWell(
           onTap: () {
             close(context, dataSource[index]);
           },
           child: Html(
             data: _buildString(dataSource[index]),
             style: {
               'b': Style(
                 color: Colors.red,
                 fontSize: FontSize(25),
               )
             },
           ),
         ),
       )
   );
  }

  String _buildString(String source) {
    if(query != '' && source.contains(query)) {
      return source.replaceAll(query, "<b>${query}</b>");
    }
    return source;
  }

}
