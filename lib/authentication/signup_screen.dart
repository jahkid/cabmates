// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

// Internal imports
import 'package:myride/authentication/login_screen.dart';
import 'package:myride/authentication/ride_info.dart';
import 'package:myride/widgets/progress_dialog.dart';
import 'package:myride/global/global.dart';
import 'package:firebase_database/firebase_database.dart';

// External Imports
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm() {
    if (nameTextEditingController.text.length < 3) {
      Fluttertoast.showToast(msg: "Name must be at least 3 characters.");
    } else if (!emailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email is not valid.");
    } else if (phoneTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Phone Number is required.");
    } else if (passwordTextEditingController.text.length < 6) {
      Fluttertoast.showToast(msg: "Password must be at least 6 characters.");
    } else {
      saveDriverInfoNow();
    }
  }

  saveDriverInfoNow() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(message: "Registering, Please wait...");
        });

    final User? firebaseUser = (await fAuth
            .createUserWithEmailAndPassword(
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
      Map driverMap = {
        "id": firebaseUser.uid,
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };

      DatabaseReference driversRef =
          FirebaseDatabase.instance.ref().child("drivers");
      driversRef.child(firebaseUser.uid).set(driverMap);
      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been created.");
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => RideInfoScreen()));
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been created.");
    }
  }

  bool isPasswordVisible = false;

  // bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(220, 0, 0, 0),
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.all(0),
            child: Image.asset("assets/app_logo.png",
                height: 30, fit: BoxFit.cover),
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 218, 167, 0),
            Color.fromARGB(255, 222, 198, 94)
          ])),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Register as a Driver or Rider",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(163, 9, 9, 9),
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 34,
                    color: Color.fromARGB(184, 9, 9, 9),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Enter Name, Email and Password to sign up.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(114, 9, 9, 9),
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 10),
                  child: TextField(
                    controller: nameTextEditingController,
                    style: TextStyle(color: Colors.white, fontSize: 14.5),
                    decoration: InputDecoration(
                        prefixIconConstraints: BoxConstraints(minWidth: 45),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 22,
                        ),
                        border: InputBorder.none,
                        hintText: 'Name',
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
                    controller: phoneTextEditingController,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(color: Colors.white, fontSize: 14.5),
                    decoration: InputDecoration(
                        prefixIconConstraints: BoxConstraints(minWidth: 45),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.white,
                          size: 22,
                        ),
                        border: InputBorder.none,
                        hintText: 'Phone Number',
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
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (c) => RideInfoScreen()));
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
                        ])),
                    child: Text('Signup',
                        style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                  child: Text(
                    'By signing up you agree to our terms, conditions and privacy Policy.',
                    style: TextStyle(
                        color: Color.fromARGB(199, 255, 255, 255),
                        fontSize: 14.5),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((c) => SignUpScreen())));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Already have an account?',
                    style: TextStyle(color: Colors.black, fontSize: 13)),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => LoginScreen()));
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
                      'Login',
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





 // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //         setState(() {
                //           maleSelected = true;

                //           femaleSelected = false;
                //         });
                //       },
                //       child: Row(
                //         children: [
                //           Container(
                //               height: 20,
                //               width: 20,
                //               alignment: Alignment.center,
                //               margin: EdgeInsets.only(right: 10),
                //               decoration: BoxDecoration(
                //                   shape: BoxShape.circle,
                //                   border: Border.all(color: Colors.white60)),
                //               child: maleSelected
                //                   ? Container(
                //                       margin: EdgeInsets.all(4),
                //                       decoration: BoxDecoration(
                //                           shape: BoxShape.circle,
                //                           color: Colors.white70),
                //                     )
                //                   : SizedBox()),
                //           Text('Male',
                //               style: TextStyle(
                //                   color: Colors.white, fontSize: 14.5))
                //         ],
                //       ),
                //     ),
                //     GestureDetector(
                //       onTap: () {
                //         setState(() {
                //           femaleSelected = true;

                //           maleSelected = false;
                //         });
                //       },
                //       child: Row(
                //         children: [
                //           Container(
                //               height: 20,
                //               width: 20,
                //               alignment: Alignment.center,
                //               margin: EdgeInsets.only(right: 10),
                //               decoration: BoxDecoration(
                //                   shape: BoxShape.circle,
                //                   border: Border.all(color: Colors.white60)),
                //               child: femaleSelected
                //                   ? Container(
                //                       margin: EdgeInsets.all(4),
                //                       decoration: BoxDecoration(
                //                           shape: BoxShape.circle,
                //                           color: Colors.white70),
                //                     )
                //                   : SizedBox()),
                //           Text('Female',
                //               style: TextStyle(
                //                   color: Colors.white, fontSize: 14.5))
                //         ],
                //       ),
                //     )
                //   ],
                // ),