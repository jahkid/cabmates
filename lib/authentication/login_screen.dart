import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myride/authentication/signup_screen.dart';
import 'package:myride/global/global.dart';
import 'package:myride/mainScreens/mainScreen.dart';
import 'package:myride/widgets/progress_dialog.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  validateForm() {
    if (!emailTextEditingController.text.contains('@')) {
      Fluttertoast.showToast(msg: 'invalid email');
    } else if (passwordTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'password must be at least 4 characters');
    } else {
      loginDriverNow();
    }
  }

  loginDriverNow() async {
    showDialog(
        context: context,
        builder: (BuildContext c) {
          return ProgressDialog(
            message: 'Processin, Please wait',
          );
        },
        barrierDismissible: false);
    final User? firebaseUser = (await fAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text.trim(),
                password: passwordTextEditingController.text.trim())
            .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error" + msg.toString());
    }))
        .user;
    if (firebaseUser != null) {
      DatabaseReference driversRef =
          FirebaseDatabase.instance.ref().child("drivers");
      driversRef.child(firebaseUser.uid).once().then((driverKey) {
        final snap = driverKey.snapshot;
        if (snap.value != null) {
          currentFirebaseUser = firebaseUser;
          Fluttertoast.showToast(msg: "Login Successful");
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => homeScreen()));
        } else {
          Fluttertoast.showToast(msg: "No record exists for this user");
          fAuth.signOut();
           Navigator.push(
              context, MaterialPageRoute(builder: (c) => LoginScreen()));
        }
      });
      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Login Successful");
      Navigator.push(context, MaterialPageRoute(builder: (c) => homeScreen()));
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error occured during login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.all(20.0),
                child: Image.asset(
                  '/assets/app_logo.png',
                  height: 100,
                  width: 100,
                  fit: BoxFit.fitWidth,
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              'Login as a Driver',
              style: TextStyle(
                fontSize: 26,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: emailTextEditingController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Email',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 77, 76, 76),
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  )),
            ),
            TextField(
              controller: passwordTextEditingController,
              keyboardType: TextInputType.text,
              obscureText: true,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Password',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 77, 76, 76),
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  validateForm();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellowAccent,
                ),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.black, fontSize: 10),
                )),
            TextButton(
              child: Text(
                "Don't have an account? Register Here",
                style: TextStyle(
                  color: Colors.black38,
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => SignupScreen()));
              },
            )
          ],
        ),
      )),
    );
  }
}
