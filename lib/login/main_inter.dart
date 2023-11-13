import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../bottomnav/dashboard_screen.dart';
import '../home/welcome.dart';
import 'home.dart';
import 'main2.dart';


class Screenmain extends StatefulWidget {
  const Screenmain({super.key});

  @override
  State<Screenmain> createState() => _ScreenmainState();
}

class _ScreenmainState extends State<Screenmain> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return (const Center(
              child: CircularProgressIndicator(),
            ));
          } else if (snapshot.hasError) {
            return (const Center(
              child: Text("Something went wrong !"),
            ));
          } else if (snapshot.hasData) {
            return const DashboardScreen();
          } else {
            return const Authpage();
          }
        },
      ),
    );
  }
}
