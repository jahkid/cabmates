// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:myride/authentication/signup_screen.dart';
import 'package:myride/splashScreen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

//The main function is the starting point for all flutter apps.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyCujzh5BwyPRXjnrLD4USnZzXSGdNbOfFs", appId: "1:397719268048:android:424dec8f06ff32784a4cd5", messagingSenderId: "397719268048", projectId: "cabmates-11b84", databaseURL: "https://cabmates-11b84-default-rtdb.firebaseio.com")
  );
  runApp(
    MyApp(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'cabmates',
        home: SignUpScreen(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final Widget? child;

  MyApp({this.child});

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child!,
    );
  }
}

// const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return;
//   }