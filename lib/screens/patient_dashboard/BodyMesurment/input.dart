import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_health/screens/patient_dashboard/BodyMesurment/aim_page.dart';

const Color inactiveCard = Color(0xFFEDE1FF);
const Color activeCard = Colors.white;

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

// ignore: camel_case_types
class _InputPageState extends State<InputPage> {
  var _height = 170;
  var _weight = 60;

  Color maleCard = activeCard, femaleCard = activeCard;
  int height = 170, weight = 60, age = 20;
  double heightF = 5.57;
  String gender = "";

  void updateGenderSelected(int x) {
    if (x == 1) {
      gender = "Male";
      maleCard = inactiveCard;
      femaleCard = activeCard;
    } else {
      gender = "Female";
      maleCard = activeCard;
      femaleCard = inactiveCard;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Text(
          "Current Body Measurements",
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: const Color(0xFFF2F3F8),
      body: ListView(
        children: <Widget>[
          Container(
            height: 210,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            constraints: BoxConstraints(minWidth: 50, maxWidth: 50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              // color: Colors.grey
            ),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.deepPurple[300]),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Note: ",
                        style: TextStyle(
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "Enter the following details below to find "
                        "the Body Mass Index",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            updateGenderSelected(2);
                          });
                        },
                        child: Container(
                          width: 50,
                          height: 110,
                          decoration: BoxDecoration(
                            color: femaleCard,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black45.withOpacity(0.2),
                                  offset: const Offset(1.1, 4.0),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: 8),
                              Icon(
                                FontAwesomeIcons.venus,
                                color: Colors.deepPurple[400],
                                size: 64,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "FEMALE",
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            updateGenderSelected(1);
                          });
                        },
                        child: Container(
                          width: 50,
                          height: 110,
                          decoration: BoxDecoration(
                            color: maleCard,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black45.withOpacity(0.2),
                                  offset: const Offset(1.1, 4.0),
                                  blurRadius: 8.0),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: 8),
                              Icon(
                                FontAwesomeIcons.mars,
                                color: Colors.deepPurple[400],
                                size: 64,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "MALE",
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 175,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: activeCard,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black45.withOpacity(0.2),
                          offset: const Offset(1.1, 4.0),
                          blurRadius: 8.0),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'HEIGHT',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.deepPurple[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(
                        height: 1,
                        color: Colors.black,
                        indent: 35,
                        endIndent: 35,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(
                            _height.toString(),
                            style: const TextStyle(
                              fontSize: 28,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'cm',
                            style: TextStyle(
                                fontSize: 12, color: Colors.deepPurple[400]),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(
                            heightF.toStringAsFixed(2),
                            style: const TextStyle(
                              fontSize: 28,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Ft',
                            style: TextStyle(
                                fontSize: 12, color: Colors.deepPurple[400]),
                          ),
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 15),
                          overlayShape:
                              const RoundSliderOverlayShape(overlayRadius: 20),
                          activeTrackColor: Colors.deepPurple[400],
                          thumbColor: Colors.deepPurple[300],
                          inactiveTrackColor: Colors.black45,
                        ),
                        child: Slider(
                          value: _height.toDouble(),
                          min: 100.0,
                          max: 240.0,
                          onChanged: (double x) {
                            setState(() {
                              _height = x.round();
                              heightF = (_height * 0.0328084);
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 250,
                width: 320,
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        width: 150,
                        height: 200,
                        decoration: BoxDecoration(
                          color: activeCard,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black45.withOpacity(0.2),
                                offset: const Offset(1.1, 4.0),
                                blurRadius: 8.0),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Weight',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.deepPurple[400],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Divider(
                              height: 1,
                              color: Colors.black,
                              indent: 25,
                              endIndent: 25,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              _weight.toString(),
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.black54,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  icon: CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Colors.grey[200],
                                    child: const Icon(
                                      FontAwesomeIcons.minus,
                                      color: Colors.black,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _weight--;
                                    });
                                  },
                                ),
                                const SizedBox(width: 2),
                                IconButton(
                                  icon: CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Colors.grey[200],
                                    child: const Icon(
                                      FontAwesomeIcons.plus,
                                      color: Colors.black,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _weight++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        width: 150,
                        height: 200,
                        decoration: BoxDecoration(
                          color: activeCard,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black45.withOpacity(0.2),
                                offset: const Offset(1.1, 4.0),
                                blurRadius: 8.0),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // const SizedBox(height: 18),
                            Text(
                              "Age",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.deepPurple[400],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Divider(
                              height: 1,
                              color: Colors.black,
                              indent: 25,
                              endIndent: 25,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              age.toString(),
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.black54,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  icon: CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Colors.grey[200],
                                    child: const Icon(
                                      FontAwesomeIcons.minus,
                                      color: Colors.black,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      age--;
                                    });
                                  },
                                ),
                                const SizedBox(width: 14),
                                IconButton(
                                  icon: CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Colors.grey[200],
                                    child: const Icon(
                                      FontAwesomeIcons.plus,
                                      color: Colors.black,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      age++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 48,right: 48),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AimPage(
                                height: _height,
                                weight: _weight,
                                gender: gender,
                                age: age,
                              )));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(99),
                  ),
                  elevation: 8,
                  shadowColor: Colors.black45.withOpacity(0.2),
                  minimumSize: const Size(50, 50),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
