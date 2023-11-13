
import 'package:flutter/material.dart';

import '../home/search_bar_widget.dart';
import '../utility/app_text.dart';


class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            getHeader(),
            Expanded(
              child: getOrders(),
            ),
          ],
        ),
      ),
    );
  }

  Widget getHeader() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Center(
          child: AppText(
            text: "Orders",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SearchBarWidget(),
        ),
      ],
    );
  }

  Widget getOrders() {
    return ListView.builder(
      itemCount: ordersItems.length,
      itemBuilder: (context, index) {
        OrdersItem ordersItem = ordersItems[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            children: [
              Text(
                ordersItem.label,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        );
      },
    );
  }
}

class OrdersItem {
  final String label;

  OrdersItem(this.label);
}

List<OrdersItem> ordersItems = [
  OrdersItem("12/09/2023 SNiVY Plantation"),
  OrdersItem("13/09/2023 SNiVY Plantation"),
  OrdersItem("21/09/2023 Allison's Farm"),
  OrdersItem("27/09/2023 Allison's Farm"),
];
