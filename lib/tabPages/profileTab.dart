import 'package:flutter/material.dart';
import 'package:myride/authentication/login_screen.dart';
import 'package:myride/global/global.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('sign out'),
        onPressed: () {
          fAuth.signOut();
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => LoginScreen()));
        },
      ),
    );
  }
}
