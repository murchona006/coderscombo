import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  static final _auth = FirebaseAuth.instance; // INITIALIZE THE FIREBASE AUTH FILE AND CREATE AN INSTANCE
  static final _fireStore = FirebaseFirestore.instance; // INITIALIZE THE FIRESTORE FILE AND CREATE AN INSTANCE

  static Future<bool> signUp(String name, String email, String password) async{
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password); // CALL A BUILD-IN METHOD 'createUserWithEmailAndPassword' in the auth package.
      User? signedInUser = authResult.user; // USER DATA PASSES IN THE 'SignedInUser' VAR

      if (signedInUser != null){ //CHECK USER DATA IS PRESENT OR NOT
        _fireStore.collection('users').doc(signedInUser.uid).set({ //CREATE A DOCUMENT ON THE 'users' COLLECTION & THE DOCIMENT NAME SHOULD BE THE AUTO GENARATED USER ID.
          'name': name,
          'email': email,
          'profilePicture': '',
          'coverImage': '',
          'bio': '',
        }); // CREATE THE FIELDS IN THE PARTICULAR DOCUMENT
        return true; // RETURN TRUE FOR ALL DONE.
      }
      return false;
    }
    catch(e){
      print(e);
      return false;
    }
  }

  static Future<bool> login(String email, String password) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password); // CHECK THE USER DATA BY CALLING 'signInWithEmailAndPassword" METHOD USER THE AUTH PACKAGE.
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

  static void logOut(){
    try{
      _auth.signOut(); // CALL FIREBASE AUTH'S BUILD-IN METHOD 'signOut()' FOR LOGOUT THE CURRENT USER.
    }
    catch(e){
      print(e);
    }
  }

}