import 'package:coderscombo/Constants/Constants.dart';
import 'package:coderscombo/Screens/LoginScreen.dart';
import 'package:coderscombo/Services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

// EmailAuth emailAuth;

// EmailAuth emailAuth = new EmailAuth(sessionName: "Sample session");

class _RegistrationScreenState extends State<RegistrationScreen> {
  // bool submitValid = false;

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _otpControllar = TextEditingController();
  EmailOTP myauth = EmailOTP();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   emailAuth = new EmailAuth(
  //     sessionName: "Sample session",
  //   );


  //   /// Configuring the remote server
  //   emailAuth.config(remoteServerConfiguration);
  // }

  // void verify() {
  //   // print(emailAuth.validateOtp(
  //   //     recipientMail: _emailcontroller.value.text,
  //   //     userOtp: _otpControllar.value.text));

  //   var res = emailAuth.validateOtp(
  //       recipientMail: _emailcontroller.text,
  //       userOtp: _otpControllar.value.text);

  //   if (res) {
  //     print("OTP Verified");
  //   } else {
  //     print("Invalid OTP");
  //   }
  // }

  /// a void funtion to send the OTP to the user
  /// Can also be converted into a Boolean function and render accordingly for providers
  // void sendOtp() async {
  //   var result = await emailAuth.sendOtp(
  //       recipientMail: _emailcontroller.value.text, otpLength: 5);

  //   if (result) {
  //     print("OTP Sent");
  //   } else {
  //     print("We could not send the OTP");
  //   }
  // }

  late String _email;
  late String _password;
  late String _name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Icon(
                  Icons.app_registration,
                  size: 100,
                  color: AppColor_Blue,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Welcome to Coders World!',
                  style: TextStyle(
                    color: AppColor_Black,
                    fontSize: 16,
                  ),
                ),

                // Text Field-------
                SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    controller: _emailcontroller,
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
                      suffixIcon: TextButton(
                        child: Text("Send OTP"),
                        onPressed: () async {
                          myauth.setConfig(
                              appEmail: "coderscombo.com",
                              appName: "Email OTP",
                              userEmail: _emailcontroller.text,
                              otpLength: 6,
                              otpType: OTPType.digitsOnly);
                          if (await myauth.sendOTP() == true) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("OTP has been sent"),
                            ));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Oops, OTP send failed"),
                            ));
                          }
                        },
                      ),
                    ),
                    onChanged: (value) {
                      _email = value;
                    },
                  ),
                ),

                SizedBox(
                  height: 15,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    controller: _otpControllar,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'OTP',
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      ),
                    ),
                    onChanged: (value) {
                      _password = value;
                    },
                  ),
                ),

                SizedBox(height: 15),

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
                        hintText: 'Name',
                        hintStyle: TextStyle(
                          color: Colors.black26,
                        )),
                    onChanged: (value) {
                      _name = value;
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
                    'SIGN UP',
                    style: TextStyle(color: AppColor_Blue, fontSize: 20),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () async {
                    bool isValid =
                        await AuthService.signUp(_name, _email, _password);
                    if (await myauth.verifyOTP(otp: _otpControllar.text) ==
                            true &&
                        isValid) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("OTP is verified"),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Invalid OTP"),
                      ));
                      print('Registration Error!');
                    }
                    // bool isValid =
                    //     await AuthService.signUp(_name, _email, _password);

                    // if (isValid) {
                    //   Navigator.pop(context);
                    // } else {
                    //   print('Registration Error!');
                    // }
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
                      Text(
                        'Already have an account!',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                        child: Text(
                          ' LogIn',
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
