import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/screens/Settings_Pages/new_password.dart';

// import 'package:mental_health/screens/patient_dashboard/my_diary/meals_list_view.dart';
import 'package:mental_health/screens/patient_dashboard/my_diary/daily_journal.dart';
import 'package:mental_health/services/database.dart';
import 'add_new_food.dart';

double tCalorie = 0;
double tCarbs = 0;
double tProtein = 0;
double tFat = 0;
double tSugars = 0;
double tCholesterol = 0;

class Dinner extends StatefulWidget {
  String callingText;

  Dinner({Key? key, required this.callingText}) : super(key: key);

  @override
  _DinnerState createState() => _DinnerState();
}

class _DinnerState extends State<Dinner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.callingText),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          elevation: 1,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Theme.of(context).colorScheme.primary,
            icon: const Icon(
              Icons.keyboard_arrow_left_outlined,
              size: 36,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                size: 28,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () {
                if (widget.callingText == 'dinner') {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => AddNewFoodPage(
                            callingText: "dinner",
                          )));
                }
                if (widget.callingText == 'lunch') {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => AddNewFoodPage(
                            callingText: "lunch",
                          )));
                }
                if (widget.callingText == 'snack') {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => AddNewFoodPage(
                            callingText: "snack",
                          )));
                }
                if (widget.callingText == 'breakfast') {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => AddNewFoodPage(
                            callingText: "breakfast",
                          )));
                }
              },
            )
          ],
        ),
        body: Column(children: <Widget>[
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('userdata')
                  .doc(user.uid)
                  .collection('food_track')
                  .doc(formattedDate)
                  .collection(widget.callingText)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return const Text("There is no data");
                if (snapshot.hasData) {
                  tCalorie = 0;
                  tCarbs = 0;
                  tProtein = 0;
                  tFat = 0;
                  tSugars = 0;
                  tCholesterol = 0;
                  for (var i = 0; i < snapshot.data!.docs.length; i++) {
                    tCalorie = tCalorie +
                        double.parse(snapshot.data!.docs[i]
                            [snapshot.data!.docs[i].id]["Total Calories"]);
                    tCarbs = tCarbs +
                        double.parse(snapshot.data!.docs[i]
                            [snapshot.data!.docs[i].id]["Carbohydrate"]);
                    tProtein = tProtein +
                        double.parse(snapshot.data!.docs[i]
                            [snapshot.data!.docs[i].id]["Protein"]);
                    tFat = tFat +
                        double.parse(snapshot.data!.docs[i]
                            [snapshot.data!.docs[i].id]["Fat"]);
                    tSugars = tSugars +
                        double.parse(snapshot.data!.docs[i]
                            [snapshot.data!.docs[i].id]["Sugars"]);
                    tCholesterol = tCholesterol +
                        double.parse(snapshot.data!.docs[i]
                            [snapshot.data!.docs[i].id]["Cholesterol"]);
                  }
                  DatabaseService(uid: user.uid).updateTotalFoodData(
                      widget.callingText,
                      tCalorie.toString(),
                      tCarbs.toString(),
                      tProtein.toString(),
                      tFat.toString(),
                      tSugars.toString(),
                      tCholesterol.toString());
                }
                return getExpenseItems(snapshot);
              }),
        ]));
  }
}

getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Food",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 65),
                      Text(
                        "Total Cal",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 65),
                      Text(
                        "Carbs",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 65),
                      Text(
                        "Protein",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 65),
                      Text(
                        "Fat",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 78),
                      Text(
                        "Sugars",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 60),
                      Text(
                        "Cholesterol",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ]),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 1,
                      width: 750,
                      decoration: const BoxDecoration(color: Colors.black)),
                  for (var i = 0; i < snapshot.data!.docs.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 60,
                            child: Text(
                              snapshot.data!.docs[i].id,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 50),
                          SizedBox(
                            width: 60,
                            child: Text(
                              "${snapshot.data!.docs[i][snapshot.data!.docs[i].id]["Total Calories"]}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 50),
                          SizedBox(
                            width: 60,
                            child: Text(
                              "${snapshot.data!.docs[i][snapshot.data!.docs[i].id]["Carbohydrate"]}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 50),
                          SizedBox(
                            width: 60,
                            child: Text(
                              "${snapshot.data!.docs[i][snapshot.data!.docs[i].id]["Protein"]}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 50),
                          SizedBox(
                            width: 60,
                            child: Text(
                              "${snapshot.data!.docs[i][snapshot.data!.docs[i].id]["Fat"]}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 50),
                          SizedBox(
                            width: 60,
                            child: Text(
                              "${snapshot.data!.docs[i][snapshot.data!.docs[i].id]["Sugars"]}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 50),
                          SizedBox(
                            width: 60,
                            child: Text(
                              "${snapshot.data!.docs[i][snapshot.data!.docs[i].id]["Cholesterol"]}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ]),
          ),
        ),
      ),
    ),
  );
}
