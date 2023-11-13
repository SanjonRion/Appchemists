import 'package:flutter/material.dart';

import '../home/welcome.dart';
import '../notification/gov_notifi.dart';
import '../order/orders_screen.dart';
import '../profile/account_screen.dart';

class NavigatorItem {
  final String label;
  final String iconPath;
  final int index;
  final Widget screen;

  NavigatorItem(this.label, this.iconPath, this.index, this.screen);
}

List<NavigatorItem> navigatorItems = [
  NavigatorItem("Shop", "assets/shop_icon.svg", 0, const HomeScreen2()),
  NavigatorItem("Orders", "assets/orders_icon.svg", 1, const OrdersScreen()),
  NavigatorItem(
      "Announcements", "assets/announce_icon.svg", 2, const GovNotiScreen()),
  NavigatorItem("Profile", "assets/account_icon.svg", 4, const AccountScreen()),
];
