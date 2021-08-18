import 'package:flutter/material.dart';
import 'package:jd_core/view_model/single_view_model.dart';

/// @author jd

class ShopMyVm extends SingleViewModel {
  final List headMenu = [
    {
      'icon': Icons.memory,
      'title': '钻石',
    },
    {
      'icon': Icons.filter_center_focus,
      'title': '关注',
    },
    {
      'icon': Icons.border_horizontal,
      'title': '足迹',
    },
    {
      'icon': Icons.contact_phone,
      'title': '优惠券',
    }
  ];

  final List orderMenu = [
    {
      'icon': Icons.payment,
      'title': '待支付',
    },
    {
      'icon': Icons.send,
      'title': '待发货',
    },
    {
      'icon': Icons.receipt,
      'title': '待收货',
    },
    {
      'icon': Icons.comment,
      'title': '待评价',
    },
    {
      'icon': Icons.backpack,
      'title': '退款/售后',
    },
  ];
  final List gridMenu = [
    {
      'icon': Icons.assignment,
      'title': '发票',
    },
    {
      'icon': Icons.contact_phone,
      'title': '客服',
    },
    {
      'icon': Icons.border_color,
      'title': '意见反馈',
    },
    {
      'icon': Icons.help,
      'title': '帮助',
    },
    {
      'icon': Icons.people,
      'title': '合作伙伴',
    },
    {
      'icon': Icons.color_lens,
      'title': '我的余额',
    },
  ];

  @override
  Future loadData() {
    throw UnimplementedError();
  }

  @override
  void onCompleted(data) {}
}
