// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:myride/authentication/signup_screen.dart';
import 'package:myride/splashScreen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/global.dart';
import '../widgets/progress_dialog.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm() {
    if (!emailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email is not valid.");
    } else if (passwordTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Password is required");
    } else {
      loginDriverNow();
    }
  }

  loginDriverNow() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(message: "Signing in, Please wait...");
        });

    final User? firebaseUser = (await fAuth
            .signInWithEmailAndPassword(
      email: emailTextEditingController.text.trim(),
      password: passwordTextEditingController.text.trim(),
    )
            .catchError((msg) {
      Navigator.pop(context);
      // ignore: prefer_interpolation_to_compose_strings
      Fluttertoast.showToast(msg: "Error: " + msg.toString());
    }))
        .user;

    if (firebaseUser != null) {
      DatabaseReference driversRef =
          FirebaseDatabase.instance.ref().child("drivers");
      driversRef.child(firebaseUser.uid).once().then((driverKey) {
        final snap = driverKey.snapshot;
        if (snap.value != null) {
          currentFirebaseUser = firebaseUser;
          Fluttertoast.showToast(msg: "Login Successful.");
          Navigator.push(context,
              MaterialPageRoute(builder: (c) => const MySplashScreen()));
        } else {
          Fluttertoast.showToast(msg: "No record exist with this email.");
          fAuth.signOut();
          Navigator.push(context,
              MaterialPageRoute(builder: (c) => const MySplashScreen()));
        }
      });
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg:
              "Error! Login is Unsuccessful. Please Login with correct details");
    }
  }

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor:  Color.fromARGB(255, 218, 167, 0),
        //   automaticallyImplyLeading: true,
        //   title: Padding(
        //     padding: const EdgeInsets.all(400),
        //     child: Image.asset("assets/app_logo.png",
        //         height: 30, fit: BoxFit.cover),
        //   ),
        // ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 218, 167, 0),
            Color.fromARGB(255, 218, 168, 4)
          ])),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset("assets/app_logo.png",
                    height: 60, fit: BoxFit.cover),

                SizedBox(
                  height: 20,
                ),

                Text(
                  "WELCOME BACK",
                  style: TextStyle(
                      fontSize: 26,
                      color: Colors.black,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Login To Your Account",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(184, 9, 9, 9),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Enter Email and Password to login.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(114, 9, 9, 9),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 10),
                  child: TextField(
                    controller: emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white, fontSize: 14.5),
                    decoration: InputDecoration(
                        prefixIconConstraints: BoxConstraints(minWidth: 45),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                          size: 22,
                        ),
                        border: InputBorder.none,
                        hintText: 'Email',
                        hintStyle:
                            TextStyle(color: Colors.white, fontSize: 14.5),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)
                                .copyWith(bottomRight: Radius.circular(0)),
                            borderSide: BorderSide(color: Colors.white70)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)
                                .copyWith(bottomRight: Radius.circular(0)),
                            borderSide: BorderSide(color: Colors.white))),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 10),
                  child: TextField(
                    controller: passwordTextEditingController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.white, fontSize: 14.5),
                    obscureText: isPasswordVisible ? false : true,
                    decoration: InputDecoration(
                        prefixIconConstraints: BoxConstraints(minWidth: 45),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white,
                          size: 22,
                        ),
                        suffixIconConstraints:
                            BoxConstraints(minWidth: 45, maxWidth: 46),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          child: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white70,
                            size: 22,
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle:
                            TextStyle(color: Colors.white, fontSize: 14.5),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)
                                .copyWith(bottomRight: Radius.circular(0)),
                            borderSide: BorderSide(color: Colors.white70)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)
                                .copyWith(bottomRight: Radius.circular(0)),
                            borderSide: BorderSide(color: Colors.white))),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    validateForm();
                  },
                  child: Container(
                    height: 53,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 4,
                            color: Colors.black12.withOpacity(.2),
                            offset: Offset(2, 2))
                      ],
                      borderRadius: BorderRadius.circular(100)
                          .copyWith(bottomRight: Radius.circular(0)),
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 17, 16, 5),
                        Color.fromARGB(255, 79, 79, 22)
                      ]),
                    ),
                    child: Text('Login',
                        style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text("Don't have an account?",
                    style: TextStyle(color: Colors.black, fontSize: 16)),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => SignUpScreen()));
                  },
                  child: Container(
                    height: 53,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0x994A4008)),
                      borderRadius: BorderRadius.circular(100)
                          .copyWith(bottomRight: Radius.circular(0)),
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Color(0xFF0E0B02).withOpacity(.8),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


//  Container(
//                   height: 53,
//                   width: double.infinity,
//                   margin: EdgeInsets.symmetric(horizontal: 30),
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Color(0x994A4008)),
//                     borderRadius: BorderRadius.circular(100)
//                         .copyWith(bottomRight: Radius.circular(0)),
//                   ),
//                   child: Text('SignUp',
//                       style: TextStyle(
//                           color: Color.fromARGB(255, 72, 60, 9).withOpacity(.8),
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold)),
//                 ),