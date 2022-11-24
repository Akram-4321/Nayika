import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;
import 'package:nayika/utils/constants.dart';
import 'package:permission_handler/permission_handler.dart';

class SafeHome extends StatefulWidget {
  @override
  State<SafeHome> createState() => _SafeHomeState();
}

class _SafeHomeState extends State<SafeHome> {
  bool isLoading = false;
  loc.LocationData? locationData;
  List<Placemark>? placemark;

  showModelSafeHome(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Scaffold(
            body: isLoading
                ? Center(
                    child: progressIndicator(context),
                  )
                : SizedBox(
                    width: double.infinity,
                    child: Column(children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        locationData != null
                            ? "Latitude : ${locationData!.latitude}"
                            : "Latitude : Not Available",
                        style: TextStyle(
                            fontFamily: 'RobotoMono',
                            fontWeight: FontWeight.bold,
                            fontSize: 23 ,
                            color: Color.fromARGB(255, 40, 163, 208)),
                      ),
                      Text(
                        locationData != null
                            ? "Longitude : ${locationData!.longitude}"
                            : "Longitude : Not Available",
                        style: TextStyle(
                            fontFamily: 'RobotoMono',
                            fontWeight: FontWeight.bold,
                            fontSize: 23 ,
                            color: Color.fromARGB(255, 40, 163, 208)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: getPermission,
                        child: Text("Get Location"),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 13, 152, 149))),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        placemark != null
                            ? "Address : ${placemark![0].street}, ${placemark![0].locality}, ${placemark![0].country}"
                            : "Address : Not Available",
                        style: TextStyle(
                            fontFamily: 'RobotoMono',
                            fontWeight: FontWeight.bold,
                            fontSize: 18 ,
                            color: Color.fromARGB(255, 40, 163, 208)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: getAddress,
                        child: Text("Get Address"),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 13, 152, 149))),
                      ),
                    ]),
                  )
            // height: MediaQuery.of(context).size.height / 1.8,
            // decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.only(
            //       topLeft: Radius.circular(30),
            //       topRight: Radius.circular(30),
            //     )),
            );
      },
    );
  }

  void getPermission() async {
    if (await Permission.location.isGranted) {
      getlocation();
    } else {
      Permission.location.request();
    }
  }

  void getlocation() async {
    setState(() {
      isLoading = true;
    });
    locationData = await loc.Location.instance.getLocation();

    setState(() {
      isLoading = false;
    });
  }

  void getAddress() async {
    if (locationData != null) {
      setState(() {
        isLoading = true;
      });
      placemark = await placemarkFromCoordinates(
          locationData!.latitude!, locationData!.longitude!);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModelSafeHome(context),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 180,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                children: [
                  ListTile(
                    title: Text("Send Location"),
                    subtitle: Text("Share Location"),
                  ),
                ],
              )),
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/route.jpg')),
            ],
          ),
        ),
      ),
    );
  }
}
