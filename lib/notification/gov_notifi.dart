import 'package:flutter/material.dart';


import '../utility/app_text.dart';

class GovNotiScreen extends StatelessWidget {
  const GovNotiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: AppText(
        text: "No Notifications to display\n(Government Schemes & Farming Related Announcements will be displayed here)",
        fontWeight: FontWeight.w600,
        color: Color.fromARGB(255, 255, 68, 68),
        textAlign: TextAlign.center,
      ),
    );
  }
}
