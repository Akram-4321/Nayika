import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nayika/components/PrimaryButton.dart';
import 'package:nayika/components/SecondaryButton.dart';
import 'package:nayika/components/cumtom_textfield.dart';
import 'package:nayika/child/child_login_screen.dart';
import 'package:nayika/model/user_model.dart';
import 'package:nayika/utils/constants.dart';

class RegisterChildScreen extends StatefulWidget {
  @override
  State<RegisterChildScreen> createState() => _RegisterChildScreenState();
}

class _RegisterChildScreenState extends State<RegisterChildScreen> {
  bool isPasswordShown = true;

  final _formKey = GlobalKey<FormState>();

  final _formData = Map<String, Object>();
  bool isloading = false;

  onSubmit() async {
    _formKey.currentState!.save();
    if (_formData['password'] != _formData['rpassword']) {
      dialogueBox(context, 'Password and Retype password should be equal');
    } else {
      progressIndicator(context);
      try {
        setState(() {
          isloading = true;
        });
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _formData['cemail'].toString(),
                password: _formData['password'].toString());
        if (userCredential.user != null) {
           setState(() {
          isloading = true;
        });
          final v = userCredential.user!.uid;
          DocumentReference<Map<String, dynamic>> db =
              FirebaseFirestore.instance.collection('users').doc(v);
          final user = UserModel(
            name: _formData['name'].toString(),
            phone: _formData['phone'].toString(),
            childEmail: _formData['cemail'].toString(),
            parentEmail: _formData['gemail'].toString(),
            id: v,
            type: 'child',
          );
          final jsonData = user.toJson();
          await db.set(jsonData).whenComplete(() {
            goTo(context, LoginScreen());
            setState(() {
              isloading = false;
            });
          });
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          isloading = false;
        });
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          dialogueBox(context, 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          dialogueBox(context, 'The account already exists for that email.');
        }
      } catch (e) {
        print(e);
        setState(() {
          isloading = false;
        });
        dialogueBox(context, e.toString());
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              isloading
                  ? progressIndicator(context)
                  : SingleChildScrollView(
                      child: Column(children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "REGISTER AS CHILD",
                                textAlign: TextAlign.center,
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
                          height: MediaQuery.of(context).size.height * 0.78,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomTextField(
                                  hintText: 'Enter Name',
                                  textInputAction: TextInputAction.next,
                                  keyboardtype: TextInputType.name,
                                  prefix: Icon(Icons.person),
                                  onsave: (name) {
                                    _formData['name'] = name ?? "";
                                  },
                                  validate: (email) {
                                    if (email!.isEmpty || email.length < 3) {
                                      return 'enter correct name';
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextField(
                                  hintText: 'Enter Phone',
                                  textInputAction: TextInputAction.next,
                                  keyboardtype: TextInputType.phone,
                                  prefix: Icon(Icons.phone),
                                  onsave: (phone) {
                                    _formData['phone'] = phone ?? "";
                                  },
                                  validate: (email) {
                                    if (email!.isEmpty || email.length < 10) {
                                      return 'enter correct phone';
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextField(
                                  hintText: 'Enter Email',
                                  textInputAction: TextInputAction.next,
                                  keyboardtype: TextInputType.emailAddress,
                                  prefix: Icon(Icons.person),
                                  onsave: (email) {
                                    _formData['cemail'] = email ?? "";
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
                                  hintText: 'Enter Guardian Email',
                                  textInputAction: TextInputAction.next,
                                  keyboardtype: TextInputType.emailAddress,
                                  prefix: Icon(Icons.person),
                                  onsave: (gemail) {
                                    _formData['gemail'] = gemail ?? "";
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
                                CustomTextField(
                                  hintText: 'Retype Password',
                                  isPassword: isPasswordShown,
                                  prefix: Icon(Icons.vpn_key_rounded),
                                  onsave: (password) {
                                    _formData['rpassword'] = password ?? "";
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
                                    title: 'REGISTER',
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        onSubmit();
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ),
                        SecondaryButton(
                            title: 'Login with your account',
                            onPressed: () {
                              goTo(context, LoginScreen());
                            })
                      ]),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
