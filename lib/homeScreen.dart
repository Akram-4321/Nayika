//import 'dart:html';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

//import 'package:nayika/widgets/home_widgets/DrawerScreen.dart';

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
  final player = AudioPlayer();
  bool isPlaying = false;
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

    player.onPlayerStateChanged.listen((State) {
      setState(() {
        isPlaying = State == PlayerState.playing;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 233, 172, 230),
        actions: [
          IconButton(
            onPressed: () async {
              if (isPlaying) {
                await player.pause();
              } else {
                // final player = AudioPlayer();
               await player.play(AssetSource('Siren.mp3'));
              }
            },
            icon: Padding(
              padding: const EdgeInsets.only(right: 1),
              child: Image.asset('assets/alert1.png'),
            ),
          ),
        ],
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 30, right: 160),
          child: Image.asset(
            'assets/nayikaIcon.png',
          ),
        ),
      ),
      // drawer: DrawerScreen(),
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
