//import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:nayika/widgets/home_widgets/DrawerScreen.dart';

import 'package:nayika/widgets/home_widgets/customCarouel.dart';
import 'package:nayika/widgets/home_widgets/custom_appBar.dart';
import 'package:nayika/widgets/home_widgets/emergency.dart';
import 'package:nayika/widgets/home_widgets/safehome/SafeHome.dart';
import 'package:nayika/widgets/live_Safe.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // const HomeScreen({super.key});
  int qIndex = 0;

  getRandomQuote() {
    Random random = Random();
    setState(() {
      qIndex = random.nextInt(5);
    });
  }

  @override
  void initState() {
    getRandomQuote();
    super.initState();
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 169, 37, 235),
        title: Text(
          "Nayika",
        ),
      ),
      drawer: DrawerScreen(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomAppBar(
                  quoteIndex: qIndex,
                  onTap: () {
                    getRandomQuote();
                  }),
              Expanded(
                  child: ListView(
                shrinkWrap: true,
                children: [
                  CustomCarouel(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Emergency",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Emergency(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Explore LiveSafe",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  LiveSafe(),
                  SafeHome(),
                ],
              ))
            ],
          ),
        ),
      ),
    );
     
  }
}



