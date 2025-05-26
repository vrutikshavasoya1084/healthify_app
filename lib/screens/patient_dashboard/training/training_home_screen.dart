import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mental_health/screens/patient_dashboard/fitness_app_home_screen.dart';
import 'package:mental_health/screens/patient_dashboard/training/components/courses.dart';
import 'package:mental_health/screens/patient_dashboard/training/components/diff_styles.dart';
import 'package:mental_health/screens/patient_dashboard/training/components/video_suggestions.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({key}) : super(key: key);

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FitnessAppHomeScreen(),
            ));
          },
          color: Theme.of(context).colorScheme.primary,
          icon: const Icon(
            Icons.keyboard_arrow_left_outlined,
            size: 36,
          ),
        ),
        title: Text(
          "Training",
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
            child: Column(
              children: const <Widget>[
                VideoSuggestions(),
                DiffStyles(),
                Courses(),
                SizedBox(height: 80)
              ],
            ),
          )
        ],
      ),
    );
  }
}
