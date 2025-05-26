import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mental_health/screens/sign_in_page.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({Key? key}) : super(key: key);

  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  late String _email;
  final auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SignInPage(),
            ));
          },
          color: Theme.of(context).colorScheme.primary,
          icon: const Icon(
            Icons.keyboard_arrow_left_outlined,
            size: 36,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          "Reset password",
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(1),
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.mail),
                                hintText: "Enter your email",
                                hintStyle: TextStyle(color: Colors.black45),
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () async {
                  _email = emailController.text;
                  if (_email.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please enter your email address')),
                    );
                    return;
                  }
                  try {
                    auth.sendPasswordResetEmail(email: _email);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  SignInPage()));
                    Fluttertoast.showToast(
                        msg: "A reset password email has been sent to $_email",
                        gravity: ToastGravity.TOP);
                  } catch (e) {
                    Fluttertoast.showToast(
                        msg: "Error: $e", gravity: ToastGravity.TOP);
                  }
                },
                child: Container(
                  height: 50,
                  width: 150,
                  margin: const EdgeInsets.symmetric(horizontal: 75),
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
                      "Send Request",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
