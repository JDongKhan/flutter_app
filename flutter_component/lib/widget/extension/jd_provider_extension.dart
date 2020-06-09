import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
//export 'package:widget_chain/widget_chain.dart';

extension ProviderChain on Widget {
  MultiProvider addProviders(List<SingleChildWidget> providers) {
    return MultiProvider(
      providers: providers,
      child: this,
    );
  }
}



//extension Provider2222Chain on String {
//
//}
