import 'package:flutter/material.dart';
import 'package:misty/screens/home_screen.dart';
import 'package:misty/widgets/button_widget.dart';
import 'package:misty/widgets/text_widget.dart';
import 'package:misty/widgets/textfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final passController = TextEditingController();
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
            Image.asset(
              'assets/images/logo.png',
            ),
            const SizedBox(
              height: 20,
            ),
            TextBold(
              text: 'Welcome Back !',
              fontSize: 32,
              color: Colors.black,
            ),
            TextBold(
              text: 'Please enter your password',
              fontSize: 24,
              color: Colors.green,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              isObscure: true,
              isPassword: true,
              label: 'Password',
              controller: passController,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 45, right: 45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: check3,
                        onChanged: (value) {
                          setState(() {
                            check3 = !check3;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 100,
                        child: Text(
                          'Remember Me',
                          style: TextStyle(
                              fontFamily: 'QRegular',
                              fontSize: 12,
                              color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: TextBold(
                      text: 'Forgot Password?',
                      fontSize: 12,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              radius: 100,
              color: Colors.green,
              label: 'LOG IN',
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
