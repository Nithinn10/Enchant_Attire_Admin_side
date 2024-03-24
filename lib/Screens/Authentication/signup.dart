
import 'dart:developer';

import 'package:enchant_attire_admin/Screens/Authentication/Home/home.dart';
import 'package:enchant_attire_admin/controllers/auth_controller.dart';
import 'package:flutter/gestures.dart';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widgets/button.dart';
import '../../common_widgets/custom_widgets.dart';
import '../../consts/consts.dart';
import '../../consts/strings.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> form_key = GlobalKey<FormState>();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passEditingController = TextEditingController();
  TextEditingController cnpEditingController = TextEditingController();
  TextEditingController userEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double textFieldWidth = MediaQuery.of(context).size.width * 0.9;
    var controller = Get.put(AuthController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                    child: Image.asset(
                      offllogo,
                      width: 130,
                      height: 130,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Create your account',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                customTextField(
                  hint: emailhint,
                  title: username,
                  textInputType: TextInputType.multiline,
                  controller: emailEditingController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'enter email';
                    }
                    if (!EmailValidator.validate(value)) {
                      return 'Please enter a valid email';
                    }

                    return null;
                  },
                ),
                customTextField(
                  hint: emailhint,
                  title: username,
                  textInputType: TextInputType.multiline,
                  controller: userEditingController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Username';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 10),
                customTextField(
                    hint: passwordHint,
                    title: password,
                    textInputType: TextInputType.multiline,
                    obscureText: true,
                    controller: passEditingController,
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
                    }),
                const SizedBox(height: 10),
                customTextField(
                    hint: passwordHint,
                    title: cnfrm,
                    textInputType: TextInputType.multiline,
                    obscureText: true,
                    controller: cnpEditingController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Password';
                      }
                      // if (value != passEditingController)
                      //   return 'Password does not match';
                      return null;
                    }),
                const SizedBox(height: 10),
                 CustomButton(
                    context, 
                    textFieldWidth, 
                    signup, 
                    onPressed: () async {
                      if (form_key.currentState!.validate()) {
                        try {
                          // Show circular loading indicator
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );

                          // Call the signup method
                          await controller.signupMethod(
                            context: context, 
                            email: emailEditingController.text, 
                            password: passEditingController.text
                          );
                          
                          // Store user data after signup
                          await controller.storeUserData(
                            email: emailEditingController.text,
                            username: userEditingController.text,
                            password: passEditingController.text,
                          );

                          // Dismiss the loading indicator
                          Navigator.of(context).pop();

                          // Navigate to WelcomeScreen after successful signup
                          Get.offAll(Home());
                          log("Account Created Successfully");
                        } catch (e) {
                          // Handle signup errors
                          log(e.toString());

                          // Dismiss the loading indicator
                          Navigator.of(context).pop();

                          // Show error message
                          VxToast.show(context, msg: e.toString());
                        }
                      }
                    },
                  ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Have an account? ',
                      style: TextStyle(color: Colors.black),
                    ),
                    Text.rich(
                      TextSpan(
                        text: 'Login',
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}