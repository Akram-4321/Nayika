import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ArmyEmergency extends StatelessWidget {
  callNumber(String number) async{
  await FlutterPhoneDirectCaller.callNumber(number);
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
            ),
        child: InkWell(
          onTap: () => callNumber('8800781532'),
          child: Container(
            height: 180,
            width: MediaQuery.of(context).size.width*0.7,
            decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(20),
               gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFB1B2FF),
                  Color(0xFFFAAC4FF),
                  Color(0xFFFEEF1FF),
                ])
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white.withOpacity(0.5),
                    child: Image.asset('assets/nayika1.png'),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Women Helpline',
                        style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width*0.06,
                        ),
                        ),
                        Text('call 1091 for emergencies',
                        style: TextStyle(color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width*0.045,
                        ),
                        ),
                        Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
        
                          child: Center(
                            child: Text('1091',
                            style: TextStyle(color: Colors.red[300],
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width*0.055,
                        ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}