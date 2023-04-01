import 'package:coderscombo/Constants/Constants.dart';
import 'package:coderscombo/Screens/LoginScreen.dart';
import 'package:coderscombo/Screens/RegistrationScreen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor_Blue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                  ),
                  Image.asset(
                    'assets/Logo_TW1.png',
                    height: 300,
                    width: 300,
                  ),
                ],
              ),

              Column(
                children: [
                  MaterialButton(
                      elevation: 20,
                      color: AppColor_White,
                      child: Text(
                        'LOG IN',
                        style: TextStyle(color: AppColor_Blue, fontSize: 20),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                      ),
                      onPressed: (){
                        Navigator.push(
                          context, MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                    minWidth: 320,
                    height: 60,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MaterialButton(
                    elevation: 20,
                    color: AppColor_White,
                    child: Text(
                      'CREATE ACCOUNT',
                      style: TextStyle(color: AppColor_Blue, fontSize: 20),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    ),
                    onPressed: (){
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context) => RegistrationScreen()),
                      );
                    },
                    minWidth: 320,
                    height: 60,
                  ),


                ],
              )


            ],
          ),
        ),
      )
    );
  }
}
