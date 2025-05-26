import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mental_health/screens/patient_dashboard/doctor_appointment/components/category_card.dart';
import 'package:mental_health/screens/patient_dashboard/doctor_appointment/components/doctor_card.dart';
import '../../fitness_app_home_screen.dart';
import '../components/search_doctor_page.dart';
import '../constant.dart';
import 'doctor_model.dart';

class DoctorAppointment extends StatefulWidget {
  const DoctorAppointment({Key? key}) : super(key: key);

  @override
  State<DoctorAppointment> createState() => _DoctorAppointmentState();
}

class _DoctorAppointmentState extends State<DoctorAppointment> {
  @override
  void initState() {
    super.initState();
  }

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
          "Doctor\'s Appointment",
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Find Your Desired\nDoctor',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black.withOpacity(0.45),
                  ),
                ),
              ),
              // const SizedBox(height: 30),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 30),
              //   child: SearchDoctorPage(),
              // ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              buildCategoryList(),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Available Doctors',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              buildDoctorList(),
            ],
          ),
        ),
      ),
    );
  }

  buildCategoryList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          const SizedBox(width: 30),
          CategoryCard('Psychiatrist', 'assets/icons/psychiatrist.png',
              kOrangeColor, 'Psychiatrist'),
          const SizedBox(width: 10),
          CategoryCard('Psychologists', 'assets/icons/psychology.png',
              kBlueColor, 'Psychologists'),
          const SizedBox(width: 10),
          CategoryCard('Psychoanalyst', 'assets/icons/psychoanalyst.png',
              kYellowColor, 'Heart Surgeon'),
          // const SizedBox(width: 10),
          // CategoryCard('Eye\nSpecialist', 'assets/icons/eye_specialist.png',
          //     kOrangeColor, 'Eye Specialist'),
          const SizedBox(width: 30),
        ],
      ),
    );
  }

  List<DoctorModel> doctors = [DoctorModel("", "", "", "", "", "")];

  buildDoctorList() {
    doctors.removeAt(0);
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('userdata').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            for (var element in snapshot.data!.docs) {
              try {
                if (element['type'] == "doctor") {
                  doctors.add(DoctorModel(
                      element.id,
                      element['name'],
                      element['specialization'],
                      element['phone'],
                      element['hospital'],
                      element['about']));
                }
              } catch (e) {
                continue;
              }
            }
          }
          return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: (doctors.length <= 3) ? doctors.length : 3,
                    itemBuilder: (context, index) {
                      return Column(
                        children: (snapshot.data != null)
                            ? ([
                          DoctorCard(
                            doctors[index].uid,
                            doctors[index].displayName,
                            "${doctors[index].specialization!}-${doctors[index].hospital!}",
                            (index % 2 == 0) ? kBlueColor : kYellowColor,
                            doctors[index].bio,
                          ),
                          const SizedBox(height: 10)
                        ])
                            : ([const CircularProgressIndicator()]),
                      );
                    },
                  ),
                  const SizedBox(height: 80),
                ],
              ));
        });
  }

  getDoctors() async {
    setState(() {});
    FirebaseFirestore.instance
        .collection('userdata')
        .snapshots()
        .listen((event) {
      for (var element in event.docs) {
        try {
          if (element['type'] == "doctor") {
            doctors.add(DoctorModel(
                element.id,
                element['name'],
                element['specialization'],
                element['phone'],
                element['hospital'],
                element['about']));
          }
        } catch (e) {
          continue;
        }
      }
    });
  }
}
