import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';

import '../../common_widgets/applogo_widgets.dart';
import '../../common_widgets/button.dart';
import '../../common_widgets/custom_widgets.dart';
import '../../consts/consts.dart';
import '../../controllers/auth_controller.dart';
import 'Home/home.dart';
import 'Signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  User? user;
  GlobalKey<FormState> form_key = GlobalKey<FormState>();
  var controller = Get.put(AuthController());

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    auth.authStateChanges().listen((event) {
      setState(() {
        user = event;
      });
    });
  }

  Widget build(BuildContext context) {
    double textFieldWidth = MediaQuery.of(context).size.width * 0.9;

    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug label
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: form_key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: appLogoWidget(),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        wlcm,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: enchant,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  customTextField(
                    hint: emailhint,
                    title: username,
                    textInputType: TextInputType.multiline,
                    controller: controller.usercontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter email';
                      }
                      if (!EmailValidator.validate(value)) {
                        return 'Please enter a valid email';
                      }

                      return null;
                    },
                  ),
                  customTextField(
                    hint: password,
                    title: password,
                    textInputType: TextInputType.multiline,
                    obscureText: true,
                    controller: controller.passcontroller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      } else if (!RegExp(r'^(?=.*?[a-zA-Z])(?=.*?[0-9]).{6,}$')
                          .hasMatch(value)) {
                        return 'Password must contain at least one letter and one number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomButton(context, textFieldWidth, login,
                      onPressed: () async {
                    if (_loading) return;
                    if (form_key.currentState!.validate()) {
                      setState(() {
                        _loading = true;
                      });
                      await controller.loginMethod(context: context).then((value) {
                        if (value != null) {
                          VxToast.show(context, msg: "Logged In successfully");
                          log("Logged In Successfully");
                          Get.offAll(Home());
                        }
                      }).whenComplete(() {
                        setState(() {
                          _loading = false;
                        });
                      });
                    }
                  }),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text.rich(TextSpan(
                        text: "Forgot password",
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Navigate to Forgot Password screen.
                          },
                      ))
                    ],
                  ),
                  const SizedBox(height: 60),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
