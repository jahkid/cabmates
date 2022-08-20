import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:myride/authentication/login_screen.dart';
import 'package:myride/mainScreens/mainScreen.dart';
// import 'package:myride/mainScreens/mainScreen.dart';
// import 'package:myride/authentication/signup_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "XXX ", // Your apiKey
    appId: "XXX", // Your appId
    messagingSenderId: "XXX", // Your messagingSenderId
    projectId: "XXX",
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
        primarySwatch: Colors.yellow,
      ),
      home: homeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

