import 'package:flutter/material.dart';

class RatingsTab extends StatefulWidget {
  RatingsTab({Key? key}) : super(key: key);

  @override
  State<RatingsTab> createState() => _RatingsTabState();
}

class _RatingsTabState extends State<RatingsTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Ratings page'),
    );
  }
}