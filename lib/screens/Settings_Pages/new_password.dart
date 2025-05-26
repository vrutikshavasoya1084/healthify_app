import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_health/screens/sign_in_page.dart';

final auth = FirebaseAuth.instance;
User user = auth.currentUser!;
bool reauthChecker = false;

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<ChangePassPage> {
  final oldpassController = TextEditingController();
  final newpassController = TextEditingController();
  final confirmpassController = TextEditingController();
  bool newpasswordVisible = false;
  bool confirmpasswordVisible = false;
  bool oldpasswordVisible = false;

  @override
  void initState() {
    super.initState();
    newpasswordVisible = false;
    confirmpasswordVisible = false;
    oldpasswordVisible = false;
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
          icon: const Icon(Icons.keyboard_arrow_left_outlined, size: 36),
        ),
        title: Text(
          "Change Password",
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 4),
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
                            controller: oldpassController,
                            keyboardType: TextInputType.text,
                            obscureText: !oldpasswordVisible,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              hintText: 'Enter your old password',
                              hintStyle: const TextStyle(color: Colors.black45),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  oldpasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black45,
                                ),
                                onPressed: () {
                                  setState(() {
                                    oldpasswordVisible = !oldpasswordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
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
                            controller: newpassController,
                            keyboardType: TextInputType.text,
                            obscureText: !newpasswordVisible,
                            //This will obscure text dynamically
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              hintText: 'Enter your new password',
                              hintStyle: const TextStyle(color: Colors.black45),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  newpasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black45,
                                ),
                                onPressed: () {
                                  setState(() {
                                    newpasswordVisible = !newpasswordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
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
                            controller: confirmpassController,
                            keyboardType: TextInputType.text,
                            obscureText: !confirmpasswordVisible,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              hintText: 'Confirm the new password',
                              hintStyle: const TextStyle(color: Colors.black45),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  confirmpasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black45,
                                ),
                                onPressed: () {
                                  setState(() {
                                    confirmpasswordVisible =
                                        !confirmpasswordVisible;
                                  });
                                },
                              ),
                            ),
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
              ElevatedButton(
                onPressed: () async {
                  if (newpassController.text == confirmpassController.text) {
                    AuthCredential credential = EmailAuthProvider.credential(
                      email: user.email.toString(),
                      password: oldpassController.text,
                    );
                    try {
                      await user.reauthenticateWithCredential(credential);
                      reauthChecker = true;
                    } catch (e) {
                      reauthChecker = false;
                    }
                    if (reauthChecker == true) {
                      updatePassword(newpassController.text);
                      Fluttertoast.showToast(
                        msg: "Password has been reset",
                        gravity: ToastGravity.TOP,
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: "Invalid old password",
                        gravity: ToastGravity.TOP,
                      );
                    }
                  } else {
                    Fluttertoast.showToast(
                      msg: "The new password and confirm password do not match",
                      gravity: ToastGravity.TOP,
                    );
                  }
                  if (reauthChecker == true) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => SignInPage(),
                      ),
                      (route) => false,
                    );
                    Fluttertoast.showToast(
                      msg: "Please login again with new password",
                      gravity: ToastGravity.TOP,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  side: const BorderSide(color: Colors.black12),
                  elevation: 4,
                  shadowColor: Colors.black26,
                  minimumSize: const Size(150, 50),
                ),
                child: const Text(
                  "Send Request",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> updatePassword(String password) async {
    user.updatePassword(password);
  }
}
