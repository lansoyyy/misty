import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:misty/screens/auth/login_screen.dart';
import 'package:misty/widgets/button_widget.dart';
import 'package:misty/widgets/text_widget.dart';
import 'package:misty/widgets/textfield_widget.dart';

import '../../widgets/toast_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final passController = TextEditingController();
  final emailController = TextEditingController();
  bool check3 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
              text: 'Register here!',
              fontSize: 32,
              color: Colors.black,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              label: 'Email',
              controller: emailController,
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
              height: 30,
            ),
            ButtonWidget(
              radius: 100,
              color: Colors.green,
              label: 'CREATE USER',
              onPressed: () {
                register(context);
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

  register(context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passController.text);

      showToast(
          'Account created succesfully! Login your account to continue..');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showToast('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showToast('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        showToast('The email address is not valid.');
      } else {
        showToast(e.toString());
      }
    } on Exception catch (e) {
      showToast("An error occurred: $e");
    }
  }
}
