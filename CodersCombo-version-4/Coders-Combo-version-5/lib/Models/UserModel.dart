import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String? id;
  String? name;
  String profilePicture;
  String? email;
  String? bio;
  String coverImage;

  UserModel({
    this.id,
    this.name,
    required this.profilePicture,
    this.email,
    this.bio,
    required this.coverImage
  });

  factory UserModel.fromDoc(DocumentSnapshot doc){
    return UserModel(
      id: doc.id,
      name: doc['name'],
      email: doc['email'],
      profilePicture: doc['profilePicture'],
      bio: doc['bio'],
      coverImage: doc['coverImage'],
    );
  }
}