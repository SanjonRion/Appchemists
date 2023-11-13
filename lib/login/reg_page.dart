import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../main.dart';
import '../resources/resorces.dart';
import '../text.dart';
import '../utility/utility.dart';

class Regpage extends StatefulWidget {
  final VoidCallback showloginpage;

  const Regpage({Key? key, required this.showloginpage}) : super(key: key);

  @override
  State<Regpage> createState() => _RegpageState();
}

class _RegpageState extends State<Regpage> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _firstname = TextEditingController();
  final _lastname = TextEditingController();
  final _num = TextEditingController();
  Uint8List? _image;
  String photourl = '';
  bool _isLoading = false;
  bool _isFarmer = false;

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _firstname.dispose();
    _lastname.dispose();
    _num.dispose();
    super.dispose();
  }

  Future<void> signup() async {
    if (!passwordConfirm()) {
      _showSnackBar('Passwords do not match');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _username.text.trim(),
        password: _password.text.trim(),
      );

      photourl = await StorageMethod().uploadeImage('profilename', _image!);

      await addUserDetails(
        _firstname.text.trim(),
        _lastname.text.trim(),
        _username.text.trim(),
        int.parse(_num.text.trim()),
      );

      _showSnackBar('Registration successful');
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email';
      }
      _showSnackBar(errorMessage);
    } catch (e) {
      _showSnackBar('An error occurred');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> addUserDetails(
      String firstname, String lastname, String email, int age) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .set({
      'first_name': firstname,
      'last_name': lastname,
      'email': email,
      'num': num,
      'photo_url': photourl,
      'isFramer': _isFarmer,
    });
    print(FirebaseAuth.instance.currentUser!.email);
  }

  bool passwordConfirm() {
    return _password.text.trim() == _confirmPassword.text.trim();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 19),
              Center(
                child: Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            backgroundImage: MemoryImage(_image!),
                            radius: 50,
                          )
                        : const CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://th.bing.com/th/id/OIP.awAiMS1BCAQ2xS2lcdXGlwHaHH?w=213&h=205&c=7&r=0&o=5&pid=1.7',
                            ),
                            radius: 55,
                          ),
                    Positioned(
                      bottom: -9,
                      left: 60,
                      child: IconButton(
                        onPressed: () {
                          selectImage();
                        },
                        icon: const Icon(Icons.add_photo_alternate),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Register below with your details',
                style: TextStyle(color: Colors.grey[500]),
              ),
              const SizedBox(height: 5),
              TextField1(
                controllers: _firstname,
                hint: 'Firstname',
                obscuretext: false,
              ),
              const SizedBox(height: 1),
              TextField1(
                controllers: _lastname,
                hint: 'Lastname',
                obscuretext: false,
              ),
              const SizedBox(height: 1),
              TextField1(
                controllers: _username,
                hint: 'Email',
                obscuretext: false,
              ),
              TextField1(
                controllers: _password,
                hint: 'Password',
                obscuretext: true,
              ),
              const SizedBox(height: 1),
              TextField1(
                controllers: _confirmPassword,
                hint: 'Confirm password',
                obscuretext: true,
              ),
              const SizedBox(height: 1),
              TextField1(
                controllers: _num,
                hint: 'Number',
                obscuretext: false,
              ),
              const SizedBox(height: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _isFarmer,
                    onChanged: (value) {
                      setState(() {
                        _isFarmer = value ?? false;
                      });
                    },
                  ),
                  const Text('I am a farmer'),
                ],
              ),
              ElevatedButton(
                onPressed: _isLoading ? null : signup,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(350, 60),
                  backgroundColor: Colors.black,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 2,
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text('Sign Up'),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'I am a member?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10,),
                  GestureDetector(
                    onTap: widget.showloginpage,
                    child: const Text(
                      'Login now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
