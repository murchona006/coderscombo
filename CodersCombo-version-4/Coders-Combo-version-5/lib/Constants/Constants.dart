import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

const Color AppColor_Blue = Color.fromARGB(255, 89, 180, 255);
const Color AppColor_Black = Colors.black;
const Color AppColor_Gray = Colors.grey;
const Color AppColor_White = Colors.white;

final _fireStore = FirebaseFirestore.instance; // INITIALIZED FIREBASE FILE AND CREATE NEW INSTANCE & SAVE INTO A VAR.

final usersRef = _fireStore.collection('users'); //  CREATE A REFERENCES CALLED USERS, THAT REFERENCE IS THE FIRESTORE COLLECTION.

final followersRef = _fireStore.collection('followers'); // CREATE A REFERENCES CALLED FOLLOWERS, THAT REFERENCE IS THE FIRESTORE COLLECTION.

final followingRef = _fireStore.collection('following'); // CREATE A REFERENCE CALLED FOLLOWING, THAT REFERENCE IS THE FIRESTORE COLLECTION.

final storageRef = FirebaseStorage.instance.ref(); // CREATE A FIREBASE STORAGE REFERENCE TO USE IT.

final postsRef = _fireStore.collection('posts'); // CREATE A REFERENCES CALLED POST, THAT REFERENCE IS THE FIRESTORE COLLECTION.

final feedRef = _fireStore.collection('feeds'); // CREATE A REFERENCE CALLED FEED, THAT REFERENCE IS THE FIRESTORE COLLECTION.

final likesRef = _fireStore.collection('likes'); // CREATE A REFERENCE CALLED LIKES, THAT REFERENCE IS THE FIRESTORE COLLECTION.

final activitiesRef = _fireStore.collection('activities'); //  CREATE A REFERENCE CALLED ACTIVITIES, THAT REFERENCE IS THE FIRESTORE COLLECTION.


