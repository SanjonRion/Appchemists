// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/search_bar_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/user.dart';
import '../staff/staff1.dart';
import '../state/state.dart';
import '../utility/colors.dart';
import 'cards.dart';

class HomeScreen2 extends ConsumerWidget {
  const HomeScreen2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(selectedUser.state).state;

    Future<DocumentSnapshot> fetchUserData() async {
      return await FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFE6F7E5),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              FutureBuilder<DocumentSnapshot>(
                future: fetchUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData ||
                      snapshot.data!.data() == null) {
                    return const Center(child: Text('No data found'));
                  } else {
                    UserData userData = UserData.fromMap(
                      snapshot.data!.data()! as Map<String, dynamic>,
                    );
                    ref.read(selectedUser.state).state.firstname =
                        userData.firstname;
                    ref.read(selectedUser.state).state.lastname =
                        userData.lastname;
                    ref.read(selectedUser.state).state.age = userData.age;
                    ref.read(selectedUser.state).state.email = userData.email;
                    ref.read(selectedUser.state).state.isFramer =
                        userData.isFramer;
                    ref.read(selectedUser.state).state.photourl =
                        userData.photourl;

                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(25.0),
                            child: const Text("Farm Fresh",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor)),
                          ),

                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: SearchBarWidget(),
                          ),

                          CustomCard(
                            imagePath: 'assets/card_image1.jpg',
                            title: 'SNiVY Plantation',
                            description: 'Grapes, Melon, Berries, Pineapple',
                          ),
                          CustomCard(
                            imagePath: 'assets/card_image2.jpg',
                            title: 'Allison’s Farm',
                            description: 'Corn, Pumpkin',
                          ),
                          CustomCard(
                            imagePath: 'assets/card_image1.jpg',
                            title: 'Card Title 1',
                            description: 'Description for Card 1',
                          ),
                          CustomCard(
                            imagePath: 'assets/card_image2.jpg',
                            title: 'Card Title 2',
                            description: 'Description for Card 2',
                          ),
                          buildLookbookCard(image: 'https://img.freepik.com/free-photo/market-concept-with-vegetables_23-2149002415.jpg?size=626&ext=jpg&ga=GA1.1.44546679.1699660800&semt=ais', text: 'Card3', onTap: (){})
                          // Add more CustomCard widgets as needed
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLookbookCard({
    required String image,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 6,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black54,
                ],
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(text,style:GoogleFonts.robotoMono(fontSize: 30,color: Colors.white),),
            )
          ),
        ),
      ),
    );
  }
}
