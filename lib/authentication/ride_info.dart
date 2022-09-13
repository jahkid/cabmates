// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:myride/global/global.dart';
import 'package:myride/splashScreen/splash_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RideInfoScreen extends StatefulWidget {
  const RideInfoScreen({Key? key}) : super(key: key);

  @override
  State<RideInfoScreen> createState() => _RideInfoScreenState();
}

class _RideInfoScreenState extends State<RideInfoScreen> {
  TextEditingController carModelTextEditingController = TextEditingController();
  TextEditingController carNumberTextEditingController =
      TextEditingController();
  TextEditingController carColorTextEditingController = TextEditingController();

  List<String> carTypesList = ['Car', 'Van', 'Truck', 'Tricycle', 'Bike'];
  String? selectedCarType;

  saveCarInfo() {
    Map driverCarInfoMap = {
      "car_color": carColorTextEditingController.text.trim(),
      "car_number": carNumberTextEditingController.text.trim(),
      "car_model": carModelTextEditingController.text.trim(),
      "type": selectedCarType,
    };

    DatabaseReference driversRef =
        FirebaseDatabase.instance.ref().child("drivers");
    driversRef
        .child(currentFirebaseUser!.uid)
        .child("car_details")
        .set(driverCarInfoMap);

    Fluttertoast.showToast(msg: "Vehicle Details has been saved, Weldone!");
    Navigator.push(
        context, MaterialPageRoute(builder: (c) => MySplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset("assets/app_logo.png", height: 30),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Please Fill In Your Vehicle Details",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: carModelTextEditingController,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                    labelText: "Vehicle Model",
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: 'Enter Vehicle Model Here',
                    hintStyle:
                        TextStyle(color: Color(0x8EFFFFFF), fontSize: 10),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                TextField(
                  controller: carNumberTextEditingController,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                    labelText: "Vehicle Number",
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: 'Enter Vehicle Plate Number Here',
                    hintStyle:
                        TextStyle(color: Color(0x8EFFFFFF), fontSize: 10),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                TextField(
                  controller: carColorTextEditingController,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                    labelText: "Vehicle Color",
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: 'Enter Vehicle Color Here',
                    hintStyle:
                        TextStyle(color: Color(0x8EFFFFFF), fontSize: 10),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  " Select Type Of Vehicle",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButton(
                  dropdownColor: Colors.black54,
                  iconSize: 26,
                  hint: const Text(
                    "Choose Vehicle Type Here",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(151, 255, 255, 255)),
                  ),
                  value: selectedCarType,
                  onChanged: (newValue) {
                    setState(() {
                      selectedCarType = newValue.toString();
                    });
                  },
                  items: carTypesList.map((car) {
                    return DropdownMenuItem(
                      child: Text(
                        car,
                        style: TextStyle(color: Colors.white),
                      ),
                      value: car,
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    if (carColorTextEditingController.text.isNotEmpty &&
                        carNumberTextEditingController.text.isNotEmpty &&
                        carModelTextEditingController.text.isNotEmpty &&
                        selectedCarType != null) {
                      saveCarInfo();
                    }
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
                          Color.fromARGB(223, 255, 186, 11),
                          Color.fromARGB(255, 109, 86, 4)
                        ])),
                    child: Text('Save Now',
                        style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
