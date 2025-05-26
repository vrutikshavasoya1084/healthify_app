import 'dart:async';
import 'package:mental_health/screens/sign_in_page.dart';
import 'package:mental_health/utils/constants.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.deepPurple.shade600,
          Colors.deepPurple.shade100,
          Colors.deepPurple.shade400
        ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
              child: Image.asset("assets/images/mentalHealth.png",
                  width: double.infinity, height: 320),
            ),
            Column(
              children: [
                FlutterLogo(size: 75),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text(
                    Constants.textIntroDesc1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.deepPurple[100],
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const GetStarted(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return !isLoading
        ? SizedBox(
            width: size.width * 0.8,
            height: 50,
            child: ElevatedButton.icon(
              icon: Image.asset("assets/images/GetStarted.png",
                  width: 30, height: 30),
              onPressed: () async {
                setState(() {
                  isLoading = true;
                  Timer(
                      const Duration(milliseconds: 500),
                      () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInPage())));
                });
              },
              label: const Text(
                Constants.textStart,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .inversePrimary
                    .withOpacity(0.7),
                shadowColor: Colors.black,
                elevation: 20,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
            ),
          )
        : CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.inversePrimary.withOpacity(0.7)),
          );
  }
}
