import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'mainScreens/onBoard.dart';
// import 'package:myride/authentication/login_screen.dart';
// import 'package:myride/mainScreens/mainScreen.dart';
// import 'package:myride/authentication/signup_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyCCaB7Y8wRxWJxAvGrcYyEsol0o4efaLNE", // Your apiKey
    appId: "1:127287054783:android:83246f28f32d23fe65910a", // Your appId
    messagingSenderId: "127287054783", // Your messagingSenderId
    projectId: "cabmates-fcff2",
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
      home: onBoardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

