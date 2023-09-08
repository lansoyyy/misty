import 'package:flutter/material.dart';
import 'package:misty/screens/home_screen.dart';
import 'package:misty/widgets/button_widget.dart';
import 'package:misty/widgets/text_widget.dart';
import 'package:misty/widgets/textfield_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  bool check3 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                  ),
                ),
                Image.asset(
                  'assets/images/logo.png',
                ),
                const SizedBox(
                  width: 50,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextBold(
              text: 'Forgot Password',
              fontSize: 32,
              color: Colors.black,
            ),
            const SizedBox(
              height: 20,
            ),
            TextRegular(
              text: 'Enter your registered email to reset password',
              fontSize: 12,
              color: Colors.green,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              label: 'Email',
              controller: emailController,
            ),
            const SizedBox(
              height: 50,
            ),
            ButtonWidget(
              radius: 100,
              color: Colors.green,
              label: 'RESET',
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
              },
            ),
            const SizedBox(
              height: 75,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextRegular(
                  text: 'Made possible by the',
                  fontSize: 12,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'MISTY Group',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                      color: Colors.black,
                      fontFamily: 'QBold',
                      fontWeight: FontWeight.w900),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
