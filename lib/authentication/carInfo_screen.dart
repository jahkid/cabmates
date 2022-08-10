import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myride/global/global.dart';
import 'package:myride/mainScreens/mainScreen.dart';

class CarInfoScreen extends StatefulWidget {
  CarInfoScreen({Key? key}) : super(key: key);

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  TextEditingController carModelTextEditingController = TextEditingController();
  TextEditingController carNumberTextEditingController =
      TextEditingController();
  TextEditingController carColorTextEditingController = TextEditingController();
  List<String> carTypeList = ['uber-x', 'uber-go', 'bike'];
  String? selectedCarType;

  saveCarInfo() {
    Map driverCarInfoMap = {
      "car_color": carColorTextEditingController.text.trim(),
      "car_number": carNumberTextEditingController.text.trim(),
      "car_model": carModelTextEditingController.text.trim(),
      "type": selectedCarType
    };

    DatabaseReference driversRef =
        FirebaseDatabase.instance.ref().child("drivers");
    driversRef
        .child(currentFirebaseUser!.uid)
        .child("car_details")
        .set(driverCarInfoMap);
    Fluttertoast.showToast(msg: "car information saved");
    Navigator.push(context, MaterialPageRoute(builder: (c) => homeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Image.asset('/app_logo.png'),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Vehicle Details',
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: carModelTextEditingController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: 'Car Model',
                    hintText: 'Car Model',
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
                controller: carNumberTextEditingController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: 'Car Number',
                    hintText: 'Car Number',
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
                controller: carColorTextEditingController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: 'Car Color',
                    hintText: 'Car Color',
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
                height: 10,
              ),
              DropdownButton(
                iconSize: 40,
                dropdownColor: Colors.black,
                hint: Text(
                  'Please Select Your Vehicle Type',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
                value: selectedCarType,
                onChanged: (newValue) {
                  setState(() {
                    selectedCarType = newValue.toString();
                  });
                },
                items: carTypeList.map((car) {
                  return DropdownMenuItem(
                    child: Text(
                      car,
                      style: TextStyle(
                        color: Colors.yellow,
                      ),
                    ),
                    value: car,
                  );
                }).toList(),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (carColorTextEditingController.text.isNotEmpty &&
                        carNumberTextEditingController.text.isNotEmpty &&
                        carModelTextEditingController.text.isNotEmpty &&
                        selectedCarType != null) {
                      saveCarInfo();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                  child: Text(
                    'Save Details',
                    style: TextStyle(color: Colors.lime, fontSize: 10),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
