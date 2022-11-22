import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nayika/components/PrimaryButton.dart';
import 'package:nayika/components/SecondaryButton.dart';
import 'package:nayika/components/cumtom_textfield.dart';
import 'package:nayika/child/register_child.dart';
import 'package:nayika/homeScreen.dart';
import 'package:nayika/parent/parent_register_screen.dart';
import 'package:nayika/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordShown = true;
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool isloading = false;

  onSubmit() async {
    _formKey.currentState!.save();
    try {
      setState(() {
        isloading = true;
      });
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _formData['email'].toString(),
              password: _formData['password'].toString());
      if (userCredential.user != null) {
        setState(() {
          isloading = false;
        });
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get()
            .then((value) {
          if (value['parent']) {
            goTo(context, HomeScreen());
          }
        });
        goTo(context, HomeScreen());
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isloading = false;
      });
      if (e.code == 'user-not-found') {
        dialogueBox(context, 'No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        dialogueBox(context, 'Wrong password provided for that user.');
        print('Wrong password provided for that user.');
      }
    }
    print(_formData['email']);
    print(_formData['password']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            isloading
                ? progressIndicator(context)
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "USER LOGIN",
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor),
                              ),
                              Image.asset(
                                'assets/logo.png',
                                height: 100,
                                width: 100,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomTextField(
                                  hintText: 'Enter Email',
                                  textInputAction: TextInputAction.next,
                                  keyboardtype: TextInputType.emailAddress,
                                  prefix: Icon(Icons.person),
                                  onsave: (email) {
                                    _formData['email'] = email ?? "";
                                  },
                                  validate: (email) {
                                    if (email!.isEmpty ||
                                        email.length < 3 ||
                                        !email.contains("@")) {
                                      return 'enter correct email';
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextField(
                                  hintText: 'Enter Password',
                                  isPassword: isPasswordShown,
                                  prefix: Icon(Icons.vpn_key_rounded),
                                  onsave: (password) {
                                    _formData['password'] = password ?? "";
                                  },
                                  validate: (password) {
                                    if (password!.isEmpty ||
                                        password.length < 7) {
                                      return 'enter correct password';
                                    }
                                    return null;
                                  },
                                  sufix: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isPasswordShown = !isPasswordShown;
                                        });
                                      },
                                      icon: isPasswordShown
                                          ? Icon(Icons.visibility_off)
                                          : Icon(Icons.visibility)),
                                ),
                                PrimaryButton(
                                    title: 'LOGIN',
                                    onPressed: () {
                                      // progressIndicator(context);
                                      if (_formKey.currentState!.validate()) {
                                        onSubmit();
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Forgot Password??",
                                style: TextStyle(fontSize: 18),
                              ),
                              SecondaryButton(
                                  title: 'click here', onPressed: () {}),
                            ],
                          ),
                        ),
                        SecondaryButton(
                            title: 'Register as child',
                            onPressed: () {
                              goTo(context, RegisterChildScreen());
                            }),
                        SecondaryButton(
                            title: 'Register as Parent',
                            onPressed: () {
                              goTo(context, RegisterParentScreen());
                            })
                      ],
                    ),
                  ),
          ],
        ),
      ),
    ));
  }
}
