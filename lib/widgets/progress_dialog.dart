import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProgressDialog extends StatelessWidget {
  

  String? message;
  ProgressDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.lime,
      child: Container(
        margin: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(6)
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              SizedBox(width:6 ,),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.lime),   
              ),
              SizedBox(width: 26,),
              Text(
                message!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
