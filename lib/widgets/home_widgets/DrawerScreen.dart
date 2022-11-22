// import 'package:flutter/animation.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class DrawerScreen extends StatefulWidget {
//   const DrawerScreen({super.key});

//   @override
//   State<DrawerScreen> createState() => _DrawerScreenState();
// }

// class _DrawerScreenState extends State<DrawerScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Color.fromARGB(227, 236, 109, 122),
//       child: Column(children: [
//         CircleAvatar(
//                     radius: 25,
//                     backgroundColor: Colors.white.withOpacity(0.5),
//                     child: Image.asset('assets/nayikaIcon.png'),
//                   ),
//       ]),

//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class DrawerScreen extends StatefulWidget {
  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  _callNumber(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}
