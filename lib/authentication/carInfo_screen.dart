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
  List<String> carTypeList = ['car', 'van', 'bike','truck'];
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
      backgroundColor:Color.fromARGB(255, 50, 49, 49),
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
                child: Image.asset('assets/app_logo.png',
                fit:BoxFit.contain ,
                width: 100,
                height: 100,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                ' Enter Your Vehicle Details',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40,),
              TextField(
                controller: carModelTextEditingController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: 'Car Model',
                    hintText: 'Car Model',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color:  Color.fromARGB(255, 210, 208, 208)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow),
                    ),
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 210, 208, 208),
                      fontSize: 10,
                    ),
                    labelStyle: TextStyle(
                      color:  Color.fromARGB(255, 210, 208, 208),
                      fontSize: 14,
                    )),
              ),
              TextField(
                controller: carNumberTextEditingController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: 'Car Number',
                    hintText: 'Car Number',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color:  Color.fromARGB(255, 210, 208, 208)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow),
                    ),
                    hintStyle: TextStyle(
                      color:  Color.fromARGB(255, 210, 208, 208),
                      fontSize: 10,
                    ),
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 210, 208, 208),
                      fontSize: 14,
                    )),
              ),
              TextField(
                controller: carColorTextEditingController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: 'Car Color',
                    hintText: 'Car Color',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 210, 208, 208)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow),
                    ),
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 210, 208, 208),
                      fontSize: 10,
                    ),
                    labelStyle: TextStyle(
                      color:  Color.fromARGB(255, 210, 208, 208),
                      fontSize: 14,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButton(
                iconSize: 40,
                dropdownColor:  Color.fromARGB(255, 240, 234, 234),
                hint: Text(
                  'Please Select Your Vehicle Type',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color.fromARGB(255, 240, 234, 234),
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
                        color:   Color.fromARGB(255, 240, 234, 234),
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
                  primary:Color.fromARGB(255, 234, 249, 106),
                  fixedSize: Size(200, 50),
                  ),
                  // style: ElevatedButton.styleFrom(
                  //   primary: Colors.black,
                  // ),
                  child: Text(
                    'Save Details',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
