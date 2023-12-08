import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:misty/widgets/text_widget.dart';
import 'package:misty/widgets/toast_widget.dart';

import '../widgets/button_widget.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  bool status = false;

  bool hasLoaded = false;

  getData() async {
    FirebaseDatabase.instance
        .ref('Configuration')
        .onValue
        .listen((DatabaseEvent event) async {
      final dynamic data = event.snapshot.value;

      setState(() {
        mist.text = data['Minutes'].toString();
        mis = data['Minutes'].toInt();
      });
    });

    FirebaseDatabase.instance
        .ref('Configuration')
        .onValue
        .listen((DatabaseEvent event) async {
      final dynamic data = event.snapshot.value;

      setState(() {
        temp.text = data['Temperature'].toString();
        tem = data['Temperature'].toInt();
      });
    });

    setState(() {
      hasLoaded = true;
    });

    setState(() {});
  }

  var temp = TextEditingController();
  var mist = TextEditingController();

  int tem = 0;
  int mis = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                tem = 0;
                temp.text = tem.toString();

                mis = 0;
                mist.text = mis.toString();
              });
              showToast('Set to default');
            },
            icon: const Icon(
              Icons.autorenew,
            ),
          ),
        ],
      ),
      body: hasLoaded
          ? SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextBold(
                        text: 'Custom Input',
                        fontSize: 32,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 400,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 35,
                              ),
                              TextBold(
                                text: 'Input Temperature',
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 200,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        tem = int.parse(value);
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: InputBorder.none,
                                      ),
                                      controller: temp,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            tem++;
                                            temp.text = tem.toString();
                                          });
                                        },
                                        child: const Icon(
                                          Icons.arrow_drop_up_sharp,
                                          size: 50,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (tem > 0) {
                                            setState(() {
                                              tem--;
                                              temp.text = tem.toString();
                                            });
                                          }
                                        },
                                        child: const Icon(
                                          Icons.arrow_drop_down,
                                          size: 50,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              TextBold(
                                text: 'Input Mist Time Limit',
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 200,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        mis = int.parse(value);
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: InputBorder.none,
                                      ),
                                      controller: mist,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            mis++;
                                            mist.text = mis.toString();
                                          });
                                        },
                                        child: const Icon(
                                          Icons.arrow_drop_up_sharp,
                                          size: 50,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (mis > 0) {
                                            setState(() {
                                              mis--;
                                              mist.text = mis.toString();
                                            });
                                          }
                                        },
                                        child: const Icon(
                                          Icons.arrow_drop_down,
                                          size: 50,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ButtonWidget(
                        radius: 100,
                        color: Colors.black,
                        label: 'Apply Changes',
                        onPressed: () async {
                          if (temp.text == '' && mist.text == '') {
                            showToast('No changes to apply!');
                          } else {
                            DatabaseReference ref =
                                FirebaseDatabase.instance.ref("Configuration");

// Only update the name, leave the age and address!
                            await ref.update({
                              "Temperature": tem,
                              "Minutes": mis,
                            });
                            showToast('Changes applied!');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
