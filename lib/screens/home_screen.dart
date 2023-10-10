import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:misty/screens/logs_screen.dart';
import 'package:misty/widgets/text_widget.dart';
import 'package:pretty_gauge/pretty_gauge.dart';
import 'package:wi_custom_bar/wi_custom_bar.dart';

import '../widgets/button_widget.dart';
import 'auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Random random = Random();
  String control = 'OFF';

  var hasLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  int hum = 0;
  int temp = 0;
  bool status = false;

  getData() async {
    FirebaseDatabase.instance
        .ref('SensorData')
        .onValue
        .listen((DatabaseEvent event) async {
      final dynamic data = event.snapshot.value;

      setState(() {
        hum = data['Humidity'].toInt();
      });
    });

    FirebaseDatabase.instance
        .ref('SensorData')
        .onValue
        .listen((DatabaseEvent event) async {
      final dynamic data = event.snapshot.value;

      setState(() {
        temp = data['Temperature'].toInt();
      });
    });

    FirebaseDatabase.instance
        .ref('RelayStatus')
        .onValue
        .listen((DatabaseEvent event) async {
      final dynamic data = event.snapshot.value;

      status = data['state'];
    });

    setState(() {
      hasLoaded = true;
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: hasLoaded
          ? SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: const Text(
                                            'Logout Confirmation',
                                            style: TextStyle(
                                                fontFamily: 'QBold',
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: const Text(
                                            'Are you sure you want to Logout?',
                                            style: TextStyle(
                                                fontFamily: 'QRegular'),
                                          ),
                                          actions: <Widget>[
                                            MaterialButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: const Text(
                                                'Close',
                                                style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: () async {
                                                await FirebaseAuth.instance
                                                    .signOut();
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const LoginScreen()));
                                              },
                                              child: const Text(
                                                'Continue',
                                                style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ));
                              },
                              icon: const Icon(
                                Icons.logout,
                              ),
                            ),
                            temp > 35
                                ? IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: const Text(
                                                  'Warning!',
                                                  style: TextStyle(
                                                      fontFamily: 'QBold',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                content: const Text(
                                                  'Temperature is too High! Mist is Turned ON',
                                                  style: TextStyle(
                                                      fontFamily: 'QRegular'),
                                                ),
                                                actions: <Widget>[
                                                  MaterialButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(true),
                                                    child: const Text(
                                                      'Close',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'QRegular',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ));
                                    },
                                    icon: Badge(
                                      backgroundColor: Colors.red,
                                      label: TextBold(
                                          text: '1',
                                          fontSize: 12,
                                          color: Colors.white),
                                      child: const Icon(
                                        Icons.notifications,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),

                    const Divider(
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextBold(
                      text: 'TEMPERATURE',
                      fontSize: 28,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Temp
                    Container(
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TemperatureVerticalBar(100, temp,
                              baseBgColor: Colors.white),
                          Container(
                            width: 150,
                            height: 75,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: TextBold(
                                  text: '$temp° Celsius',
                                  fontSize: 18,
                                  color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextBold(
                      text: 'HUMIDITY',
                      fontSize: 28,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Container(
                      width: 300,
                      height: 225,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                PrettyGauge(
                                  showMarkers: true,
                                  gaugeSize: 125,
                                  segments: [
                                    GaugeSegment('DRY', 20, Colors.red),
                                    GaugeSegment('NORMAL', 40, Colors.green),
                                    GaugeSegment('WET', 40, Colors.blue),
                                  ],
                                  currentValue: hum.toDouble(),
                                  displayWidget: const Text(
                                    'HUMIDITY',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                Container(
                                  width: 75,
                                  height: 75,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: TextBold(
                                        text: '${hum.toStringAsFixed(2)}%',
                                        fontSize: 18,
                                        color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            LinearGauge(
                              pointers: [
                                Pointer(
                                  pointerPosition: PointerPosition.top,
                                  shape: PointerShape.triangle,
                                  value: hum.toDouble(),
                                  color: Colors.blue,
                                ),
                              ],
                              gaugeOrientation: GaugeOrientation.horizontal,
                              valueBar: [
                                ValueBar(
                                  color: Colors.blue,
                                  value: hum.toDouble(),
                                  offset: 20,
                                  position: ValueBarPosition.top,
                                )
                              ],
                              enableGaugeAnimation: true,
                              rulers: RulerStyle(
                                rulerPosition: RulerPosition.bottom,
                                showLabel: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextBold(
                      text: 'SYSTEM CONTROL',
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ButtonWidget(
                      radius: 100,
                      color: Colors.black,
                      label: status ? 'ON' : 'OFF',
                      onPressed: () async {
                        if (status) {
                          DatabaseReference ref =
                              FirebaseDatabase.instance.ref("RelayStatus");

// Only update the name, leave the age and address!
                          await ref.update({
                            "state": false,
                          });
                        } else {
                          DatabaseReference ref =
                              FirebaseDatabase.instance.ref("RelayStatus");

// Only update the name, leave the age and address!
                          await ref.update({
                            "state": true,
                          });
                        }

                        setState(() {
                          hasLoaded = false;
                        });
                        getData();

                        // Navigator.of(context).pushReplacement(MaterialPageRoute(
                        //     builder: (context) => const HomeScreen()));
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonWidget(
                      radius: 100,
                      color: Colors.black,
                      label: 'Data Logs',
                      onPressed: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LogsScreen()));
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
