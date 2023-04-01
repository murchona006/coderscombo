import 'dart:ffi';
import 'package:coderscombo/Constants/Constants.dart';
import 'package:coderscombo/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailcontroller = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailcontroller,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                hintText: 'Email',
                hintStyle: TextStyle(
                  color: Colors.black26,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              elevation: 10,
              color: Colors.white70,
              child: Text(
                'Sent',
                style: TextStyle(color: AppColor_Blue, fontSize: 20),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              onPressed: () {
                auth
                    .sendPasswordResetEmail(
                        email: emailcontroller.text.toString())
                    .then((value) {
                  Utils().toastMessage(
                      'We have sent you email to recover password, please check email');
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              minWidth: 320,
              height: 60,
            )
          ],
        ),
      ),
    );
  }
}
