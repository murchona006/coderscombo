import 'package:coderscombo/Constants/Constants.dart';
import 'package:flutter/material.dart';

class Messenger extends StatefulWidget {
  const Messenger({Key? key}) : super(key: key);

  @override
  State<Messenger> createState() => _MessengerState();
}

class _MessengerState extends State<Messenger> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor_Blue,
    );
  }
}
