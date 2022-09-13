// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:myride/authentication/login_screen.dart';
import 'package:myride/authentication/signup_screen.dart';
import 'package:myride/global/global.dart';
import 'package:myride/mainScreens/main_screen.dart';
import "package:flutter/material.dart";

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 3), () async {
      if (await fAuth.currentUser != null) {
        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => MainScreen()));
      } else {
        //send user to Login screen
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => LoginScreen()));
      }
    }); // Timer
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          color: Colors.black,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/app_logo.png"),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          )),
    );
  }
}
