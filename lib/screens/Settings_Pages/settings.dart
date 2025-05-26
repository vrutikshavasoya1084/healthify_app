import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/screens/Doctor_Dashboard_Pages/doctor_edit_profile.dart';
import 'package:mental_health/screens/Settings_Pages/new_password.dart';
import 'package:mental_health/screens/patient_dashboard/fitness_app_home_screen.dart';
import 'package:mental_health/screens/patient_dashboard/patient_profile_edit.dart';
import 'package:mental_health/screens/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_health/services/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  final String role;

  const SettingsPage({Key? key, required this.role}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  String name = "";
  String bio = "";

  @override
  Widget build(BuildContext context) {
    User activeuser = auth.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 1,
        leading: IconButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            if (prefs.getString('login_as') == "doctor") {
              Navigator.of(context).pop();
            } else {
              if (widget.role == "doctor") {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DoctorProfile()));
              } else {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FitnessAppHomeScreen()));
              }
            }
          },
          color: Theme.of(context).colorScheme.primary,
          icon: const Icon(
            Icons.keyboard_arrow_left_outlined,
            size: 36,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('userdata').snapshots(),
          builder: (context, snapshot) {
            var sn = snapshot.data;
            if (sn != null) {
              for (var element in sn.docs) {
                if (element.id == activeuser.uid) {
                  try {
                    name = element.get("name");
                    bio = element.get("about");
                  } catch (e) {
                    name = "";
                    bio = "";
                  }
                }
              }
            }
            return Container(
              padding: const EdgeInsets.only(left: 16, top: 6, right: 16),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "  Profile",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Card(
                        color: Colors.deepPurple[200],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ListTile(
                            leading: Stack(
                              children: <Widget>[
                                const CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      "https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExMTF3amlkMjl2ZGptNXlheGQ3dmltcXdycWY5Mmgxc3NnMXNuazAxNCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3NtY188QaxDdC/giphy.gif"),
                                ),
                                Positioned(
                                  bottom: 1.0,
                                  right: 1.0,
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.deepPurple[400],
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            title: Text(
                              name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 20),
                            ),
                            subtitle: Text(
                              // 'text',
                              bio,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 14),
                            ),
                            trailing: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onTap: () {
                              if (widget.role == "doctor") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DoctorProfile()));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PatientProfileEdit()));
                              }
                              //open edit profile
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 15,
                    thickness: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ChangePassPage()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Change Password",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.deepPurple[400],
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    height: 15,
                    thickness: 1,
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => SignInPage()),
                        ModalRoute.withName(''),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Log out",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                          ),
                          Icon(
                            Icons.exit_to_app,
                            color: Colors.deepPurple[400],
                            size: 26,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    height: 15,
                    thickness: 1,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
