import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:misty/widgets/text_widget.dart';
import 'package:pretty_gauge/pretty_gauge.dart';
import 'package:wi_custom_bar/wi_custom_bar.dart';

import '../widgets/button_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Random random = Random();
  String control = 'OFF';

  @override
  Widget build(BuildContext context) {
    int temp = random.nextInt(20);
    double humid = random.nextDouble() * 100;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
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
                    TemperatureVerticalBar(100, temp + 35,
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
                            text: '${temp + 35}° Celsius',
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
                            currentValue: humid,
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
                                  text: '${humid.toStringAsFixed(2)}%',
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
                            value: humid,
                            color: Colors.blue,
                          ),
                        ],
                        gaugeOrientation: GaugeOrientation.horizontal,
                        valueBar: [
                          ValueBar(
                            color: Colors.blue,
                            value: humid,
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
                label: control,
                onPressed: () {
                  if (control == 'OFF') {
                    setState(() {
                      control = 'ON';
                    });
                  } else {
                    setState(() {
                      control = 'OFF';
                    });
                  }
                  // Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //     builder: (context) => const HomeScreen()));
                },
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
