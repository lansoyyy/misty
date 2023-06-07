import 'package:flutter/material.dart';
import 'package:misty/widgets/text_widget.dart';

import '../widgets/button_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(
                height: 50,
              ),
              TextBold(
                text: 'HUMIDITY',
                fontSize: 28,
                color: Colors.black,
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
                label: 'OFF',
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomeScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
