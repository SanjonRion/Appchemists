class AccountItem {
  final String label;
  final String iconPath;

  AccountItem(this.label, this.iconPath);
}

List<AccountItem> accountItems = [
  AccountItem("Orders", "assets/orders_icon.svg"),
  AccountItem("My Details", "assets/details_icon.svg"),
  AccountItem("Delivery Access", "assets/delivery_icon.svg"),
  AccountItem("Payment Methods", "assets/payment_icon.svg"),
  AccountItem("Help", "assets/help_icon.svg"),
  AccountItem("About", "assets/about_icon.svg"),
];
