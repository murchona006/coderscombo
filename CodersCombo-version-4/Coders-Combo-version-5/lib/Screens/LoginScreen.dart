import 'package:coderscombo/Screens/Forgot_PassScreen.dart';
import 'package:coderscombo/Screens/RegistrationScreen.dart';
import 'package:coderscombo/Screens/WelcomeScreen.dart';
import 'package:coderscombo/Services/auth_service.dart';
import 'package:flutter/material.dart';

import '../Constants/Constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _email;
  late String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Icon(
                  Icons.lock,
                  size: 100,
                  color: AppColor_Blue,
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Welcome to back Coders!',
                  style: TextStyle(
                    color: AppColor_Black,
                    fontSize: 16,
                  ),
                ),

                // Text Field-------
                // SizedBox(height: 25),
                //
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25),
                //   child: TextField(
                //     decoration: InputDecoration(
                //         enabledBorder: const OutlineInputBorder(
                //           borderSide: BorderSide(color: Colors.white),
                //         ),
                //         focusedBorder: OutlineInputBorder(
                //           borderSide: BorderSide(color: Colors.grey.shade400),
                //         ),
                //         fillColor: Colors.grey.shade200,
                //         filled: true,
                //         hintText: 'Email',
                //         hintStyle: TextStyle(
                //           color: Colors.black26,
                //         )
                //
                //     ),
                //   ),
                // ),

                SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
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
                        )),
                    onChanged: (value) {
                      _email = value;
                    },
                  ),
                ),

                SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      ),
                    ),
                    onChanged: (value) {
                      _password = value;
                    },
                  ),
                ),

                SizedBox(
                  height: 50,
                ),
                MaterialButton(
                  elevation: 10,
                  color: Colors.white70,
                  child: Text(
                    'Log In',
                    style: TextStyle(color: AppColor_Blue, fontSize: 20),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () async {
                    bool isValid = await AuthService.login(_email, _password);

                    if (isValid) {
                      Navigator.pop(context);
                    } else {
                      print('LogIn Problem');
                    }
                  },
                  minWidth: 320,
                  height: 60,
                ),

                // MOVE LOGIN PAGE

                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 55.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordScreen()),
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 75.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Do not have an account?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistrationScreen()),
                          );
                        },
                        child: Text(
                          ' Sign Up',
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
