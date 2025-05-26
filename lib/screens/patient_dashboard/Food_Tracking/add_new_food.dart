import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mental_health/screens/Settings_Pages/new_password.dart';
import 'package:mental_health/screens/patient_dashboard/my_diary/daily_journal.dart';
import 'package:mental_health/services/database.dart';

import '../fitness_app_home_screen.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

late Response response;
var dio = Dio();
String carbo = "";
String protein = "";
String fat = "";
String calories = "";
String cholesterol = "";
String sugars = "";
String foodName = "";
String quantity = "";

//ignore: must_be_immutable
class AddNewFoodPage extends StatefulWidget {
  String callingText;

  AddNewFoodPage({Key? key, required this.callingText}) : super(key: key);

  @override
  _AddNewFoodPageState createState() => _AddNewFoodPageState();
}

class _AddNewFoodPageState extends State<AddNewFoodPage> {
  String dropdownValue = 'piece';
  final foodnameController = TextEditingController();
  final carboController = TextEditingController();
  final proteinController = TextEditingController();
  final fatController = TextEditingController();
  final servingsController = TextEditingController();
  final caloriesController = TextEditingController();
  final sugarsController = TextEditingController();
  final cholesterolController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Food Item",
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const FitnessAppHomeScreen(),
              ),
            );
          },
          color: Theme.of(context).colorScheme.primary,
          icon: const Icon(
            Icons.keyboard_arrow_left_outlined,
            size: 36,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.white54),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.all(1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      controller: foodnameController,
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.fastfood),
                                        hintText: "Enter Food Name",
                                        hintStyle:
                                            TextStyle(color: Colors.black45),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.all(0),
                                        child: TextFormField(
                                          controller: servingsController,
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                            prefixIcon: Icon(Icons.food_bank),
                                            hintText: 'Servings',
                                            hintStyle: TextStyle(
                                                color: Colors.black45),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 8.0),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: DropdownButton<String>(
                                    value: dropdownValue,
                                    icon: const Icon(
                                        Icons.arrow_drop_down_circle_outlined),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;
                                      });
                                    },
                                    items: <String>['piece', 'cups']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () async {
                                httprequest("${servingsController.text} "
                                    "$dropdownValue"
                                    " ${foodnameController.text}");
                              },
                              child: Container(
                                height: 50,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 75),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.deepPurple.shade400,
                                    border: Border.all(color: Colors.black12),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black26,
                                          spreadRadius: 1,
                                          blurRadius: 4)
                                    ]),
                                child: const Center(
                                  child: Text(
                                    "Get Data",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(0),
                                    child: TextFormField(
                                      controller: caloriesController,
                                      keyboardType: const TextInputType
                                          .numberWithOptions(),
                                      decoration: InputDecoration(
                                        prefixIcon: Image.asset(
                                            'assets/icons/calories.png',
                                            height: 1),
                                        hintText:
                                            'Enter Calories Intake (in Kcal)',
                                        hintStyle:
                                            TextStyle(color: Colors.black45),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(0),
                                    child: TextFormField(
                                      controller: carboController,
                                      keyboardType: const TextInputType
                                          .numberWithOptions(),
                                      decoration: InputDecoration(
                                        prefixIcon: Image.asset(
                                            'assets/icons/wheat.png',
                                            height: 1),
                                        hintText:
                                            'Enter Carbohydrate (in grams)',
                                        hintStyle:
                                            TextStyle(color: Colors.black45),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(0),
                                    child: TextFormField(
                                      controller: proteinController,
                                      keyboardType:
                                          TextInputType.numberWithOptions(),
                                      decoration: InputDecoration(
                                        prefixIcon: Image.asset(
                                            'assets/icons/protein.png',
                                            height: 1),
                                        hintText: 'Enter Protein (in grams)',
                                        hintStyle:
                                            TextStyle(color: Colors.black45),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(0),
                                    child: TextFormField(
                                      controller: fatController,
                                      keyboardType: const TextInputType
                                          .numberWithOptions(),
                                      decoration: InputDecoration(
                                        prefixIcon: Image.asset(
                                            'assets/icons/fat.png',
                                            height: 1),
                                        hintText: 'Enter Fat (in grams)',
                                        hintStyle:
                                            TextStyle(color: Colors.black45),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(0),
                                    child: TextFormField(
                                      controller: cholesterolController,
                                      keyboardType: const TextInputType
                                          .numberWithOptions(),
                                      decoration: InputDecoration(
                                        prefixIcon: Image.asset(
                                            'assets/icons/cholesterol.png',
                                            height: 1),
                                        hintText:
                                            'Enter Cholesterol (in grams)',
                                        hintStyle:
                                            TextStyle(color: Colors.black45),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(0),
                                    child: TextFormField(
                                      controller: sugarsController,
                                      keyboardType: const TextInputType
                                          .numberWithOptions(),
                                      decoration: InputDecoration(
                                        prefixIcon: Image.asset(
                                            'assets/icons/sugar.png',
                                            height: 1),
                                        hintText: 'Enter Sugars (in grams)',
                                        hintStyle:
                                            TextStyle(color: Colors.black45),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          updateData();
                          user = auth.currentUser!;
                          await FirebaseFirestore.instance
                              .collection('userdata')
                              .doc(user.uid)
                              .collection('food_track')
                              .doc(formattedDate)
                              .collection(widget.callingText)
                              .get()
                              .then((querySnapshot) {
                            for (var result in querySnapshot.docs) {
                              result = result;
                            }
                          });

                          Fluttertoast.showToast(
                            msg: "Saved Food Nutrients Data",
                            gravity: ToastGravity.TOP,
                          );

                          Navigator.pop(context); // Pop after work is done
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple.shade400,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          side: const BorderSide(color: Colors.black12),
                          elevation: 4,
                          shadowColor: Colors.black26,
                          minimumSize:
                              const Size(150, 50), // Adjust width if needed
                        ),
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> httprequest(String name) async {
    // dio.options.headers['x-app-id'] = env['APP_ID'];
    // dio.options.headers["x-app-key"] = env['APP_KEY'];
    try {
      response = await dio.post(
          'https://trackapi.nutritionix.com/v2/natural/nutrients',
          data: {'query': name},
          options: Options(headers: {
            'x-app-id': 'c72cb8f5',
            'x-app-key': 'b7c96a6b2dd1d15967d919b523259643',
          }));
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Food not found. Please enter the data yourself',
          gravity: ToastGravity.TOP);
    }
    foodName = response.data['foods'][0]['food_name'].toString();
    calories = response.data['foods'][0]['nf_calories'].toString();
    carbo = response.data['foods'][0]['nf_total_carbohydrate'].toString();
    protein = response.data['foods'][0]['nf_protein'].toString();
    fat = response.data['foods'][0]['nf_total_fat'].toString();
    cholesterol =
        (double.parse(response.data['foods'][0]['nf_cholesterol'].toString()) /
                1000)
            .toString();
    sugars = response.data['foods'][0]['nf_sugars'].toString();
    if (response.statusCode == 200) {
      setState(() {
        foodName = foodnameController.text;
        quantity = servingsController.text;
        carboController.text = carbo;
        proteinController.text = protein;
        fatController.text = fat;
        caloriesController.text = calories;
        sugarsController.text = sugars;
        cholesterolController.text = cholesterol;
      });
    }
  }

  Future<void> updateData() async {
    user = auth.currentUser!;
    if (widget.callingText == "dinner") {
      await DatabaseService(uid: user.uid).updateFoodDataDinner(foodName,
          calories, carbo, protein, fat, sugars, cholesterol, quantity);
    }
    if (widget.callingText == "lunch") {
      await DatabaseService(uid: user.uid).updateFoodDataLunch(foodName,
          calories, carbo, protein, fat, sugars, cholesterol, quantity);
    }
    if (widget.callingText == "snack") {
      await DatabaseService(uid: user.uid).updateFoodDataSnack(foodName,
          calories, carbo, protein, fat, sugars, cholesterol, quantity);
    }
    if (widget.callingText == "breakfast") {
      await DatabaseService(uid: user.uid).updateFoodDataBreakfast(foodName,
          calories, carbo, protein, fat, sugars, cholesterol, quantity);
    }
  }
}
