// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class RatingsTabPage extends StatefulWidget {
  const RatingsTabPage({Key? key}) : super(key: key);

  @override
  _RatingsTabPageState createState() => _RatingsTabPageState();
}

class _RatingsTabPageState extends State<RatingsTabPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Ratings Page'),
    );
  }
}
