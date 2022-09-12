import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myride/authentication/signup_screen.dart';

// import 'package:myride/authentication/login_screen.dart';
// import 'package:myride/mainScreens/mainScreen.dart';
// import 'package:myride/authentication/signup_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyAOk3thnDZGf5ZBDO-LPG-NI8UeCO7or3A", // Your apiKey
    appId: "1:456593009978:android:ca5dba40f5bfcec577b403", // Your appId
    messagingSenderId: "456593009978", // Your messagingSenderId
    projectId: "cabmates-a0fb1",
    // databaseURL: "https://cabmates-a0fb1-default-rtdb.firebaseio.com/"
  ) // Your projectId
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drivers App',
      theme: ThemeData(
        primarySwatch: Colors.yellow
      ),
      home: SignupScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

