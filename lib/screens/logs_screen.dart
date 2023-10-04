import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:misty/widgets/text_widget.dart';
import 'package:misty/widgets/toast_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({super.key});

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  var hasLoaded = false;

  List hums = [];
  List temps = [];

  getData() async {
    DateTime now = DateTime.now();
    String dayString = now.day < 10 ? '0${now.day}' : '${now.day}';
    FirebaseDatabase.instance
        .ref('SensorDataList')
        .onValue
        .listen((DatabaseEvent event) async {
      final dynamic data = event.snapshot.value;

      hums = data['Humidity_list']
              ['${DateTime.now().month}-$dayString-${DateTime.now().year}']
          .values
          .toList();

      temps = data['Temperature_list']
              ['${DateTime.now().month}-$dayString-${DateTime.now().year}']
          .values
          .toList();
    });

    setState(() {
      hasLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              showToast('Page refreshed succesfullly!');
              setState(() {
                hasLoaded = false;
              });
              getData();
            },
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: hasLoaded
          ? SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextBold(
                      text: 'Humidity',
                      fontSize: 24,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Card(
                        elevation: 3,
                        child: SizedBox(
                            height: 350,
                            width: double.infinity,
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InteractiveViewer(
                                        child: SfCartesianChart(
                                            // Initialize category axis
                                            primaryXAxis: CategoryAxis(),
                                            series: <LineSeries<SalesData,
                                                String>>[
                                              LineSeries<SalesData, String>(
                                                  // Bind data source
                                                  dataSource: <SalesData>[
                                                    for (int i = 0;
                                                        i < hums.length;
                                                        i++)
                                                      SalesData(
                                                          i.toString(),
                                                          double.parse(hums[i]
                                                              .replaceAll(
                                                                  '%', ''))),
                                                  ],
                                                  xValueMapper:
                                                      (SalesData sales, _) =>
                                                          sales.year,
                                                  yValueMapper:
                                                      (SalesData sales, _) =>
                                                          sales.sales)
                                            ]),
                                      ),
                                      TextRegular(
                                          text:
                                              'Data based on the last 24 hours with 10 secs interval',
                                          fontSize: 8,
                                          color: Colors.grey)
                                    ],
                                  ),
                                ))),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextBold(
                      text: 'Temperature',
                      fontSize: 24,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Card(
                        elevation: 3,
                        child: SizedBox(
                            height: 350,
                            width: double.infinity,
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InteractiveViewer(
                                        child: SfCartesianChart(
                                            // Initialize category axis
                                            primaryXAxis: CategoryAxis(),
                                            series: <LineSeries<SalesData,
                                                String>>[
                                              LineSeries<SalesData, String>(
                                                  // Bind data source
                                                  dataSource: <SalesData>[
                                                    for (int i = 0;
                                                        i < temps.length;
                                                        i++)
                                                      SalesData(
                                                          i.toString(),
                                                          double.parse(hums[i]
                                                              .replaceAll(
                                                                  '%', ''))),
                                                  ],
                                                  xValueMapper:
                                                      (SalesData sales, _) =>
                                                          sales.year,
                                                  yValueMapper:
                                                      (SalesData sales, _) =>
                                                          sales.sales)
                                            ]),
                                      ),
                                      TextRegular(
                                          text:
                                              'Data based on the last 24 hours with 10 secs interval',
                                          fontSize: 8,
                                          color: Colors.grey)
                                    ],
                                  ),
                                ))),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
