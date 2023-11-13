// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/state/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'account_item.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String imagePath = ref.read(selectedUser.state).state.photourl;

    return Scaffold(
      backgroundColor: const Color(0xFFE6F7E5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildProfileCard(imagePath, ref),
              const SizedBox(height: 20),
              ...buildAccountItems(context),
              const SizedBox(height: 20),
              buildLogoutButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileCard(String imagePath, WidgetRef ref) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: const Color(0xFF92B992),
          backgroundImage: NetworkImage(imagePath),
        ),
        title: Text(
          '${ref.read(selectedUser.state).state.firstname} ${ref.read(selectedUser.state).state.lastname}',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF325C28),
            ),
          ),
        ),
        subtitle: Text(
          ref.read(selectedUser.state).state.email,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 16,
              color: Color(0xFF4C754F),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildAccountItems(BuildContext context) {
    return accountItems.map((accountItem) {
      return Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: SvgPicture.asset(
            accountItem.iconPath,
            width: 20,
            height: 20,
            color: const Color(0xFF325C28),
          ),
          title: Text(
            accountItem.label,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF325C28),
              ),
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Color(0xFF325C28),
          ),
          onTap: () {
            // Handle item tap
          },
        ),
      );
    }).toList();
  }

  Widget buildLogoutButton() {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          primary: const Color(0xFF92B992),
          textStyle: const TextStyle(
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              "assets/logout_icon.svg",
              width: 20,
              height: 20,
              color: Colors.white,
            ),
            Text(
              "Log Out",
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(),
          ],
        ),
        onPressed: () {
          FirebaseAuth.instance.signOut();
        },
      ),
    );
  }
}