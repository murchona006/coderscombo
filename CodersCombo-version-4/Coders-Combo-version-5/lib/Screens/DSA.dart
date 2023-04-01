import 'package:coderscombo/Constants/Constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DSA extends StatefulWidget {
  const DSA({Key? key}) : super(key: key);

  @override
  State<DSA> createState() => _DSAState();
}

class _DSAState extends State<DSA> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: 'https://showmikdebnath.github.io/DSA_blog/',
          ),
        ),
    );
  }
}
