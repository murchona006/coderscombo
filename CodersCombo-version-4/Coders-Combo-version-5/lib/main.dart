import 'package:coderscombo/Screens/FeedScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Screens/WelcomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget getScreenId(){
    return StreamBuilder<dynamic>(
      stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot){
          if(snapshot.hasData){
            return FeedScreen(currentUserId: snapshot.data.uid);
          }
          else{
            return WelcomeScreen();
          }
        }
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: getScreenId(),
      //home: WelcomeScreen(),
      //home: RegistrationScreen(),
      //home: LoginScreen(),
      //home: FeedScreen(currentUserId: '',),
    );
  }
}

