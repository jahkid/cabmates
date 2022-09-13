// ignore_for_file: library_private_types_in_public_api

import 'package:myride/global/global.dart';
import 'package:myride/splashScreen/splash_screen.dart';
import 'package:flutter/material.dart';

import '../authentication/login_screen.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({Key? key}) : super(key: key);

  @override
  _ProfileTabPageState createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          fAuth.signOut();
          Navigator.push(context,
              MaterialPageRoute(builder: (c) => const MySplashScreen()));
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.amber,
        ),
        child: const Text(
          "Sign Out",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            letterSpacing: 2,
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
