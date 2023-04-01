import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../Constants/Constants.dart';

class StorageService {
  static Future<String> uploadProfilePicture(String url, File imageFile) async {  // THIS METHOD USE TWO PARAMETER - URL, AND A IMAGE FILE.
    String? uniquePhotoId = Uuid().v4();  // GENERATED A UNIQUE ID.
    File? image = await compressImage(uniquePhotoId, imageFile);  // CALL A METHOD TO COMPRESS THE IMAGE AND SAVE IT A VARIABLE WHICH IS FILE TYPE.

    if (url.isNotEmpty) { // CHECK IMAGE URL IS VALID OR NOT
      RegExp exp = RegExp(r'userProfile_(.*).jpg'); //*****
      uniquePhotoId = exp.firstMatch(url)![1];  //*******
    }
    UploadTask uploadTask = storageRef.child('images/users/userProfile_$uniquePhotoId.jpg').putFile(image!);  //UPLOAD THE FILE IN THE LOCATION ON STROAGR/IMAGES/USERES/FILENAME.JPG
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL(); // TAKE THE LINK(STRING) TO A VARIABLE "downloadUrl" WHEN UPLOAD IS COMPLETED.
    return downloadUrl; // RETURN THE DOWNLOAD URL
  }

  // THIS METHOD IS SAME AS LIKE "uploadProfilePicture()"
  static Future<String> uploadCoverPicture(String url, File imageFile) async {

    String? uniquePhotoId = Uuid().v4();
    File? image = await compressImage(uniquePhotoId, imageFile);

    if (url.isNotEmpty) {
      RegExp exp = RegExp(r'userCover_(.*).jpg');
      uniquePhotoId = exp.firstMatch(url)![1];
    }
    UploadTask uploadTask = storageRef
        .child('images/users/userCover_$uniquePhotoId.jpg')
        .putFile(image!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  static Future<String> uploadTweetPicture(File imageFile) async {
    String uniquePhotoId = Uuid().v4();
    File? image = await compressImage(uniquePhotoId, imageFile);

    UploadTask uploadTask = storageRef
        .child('images/posts/post_$uniquePhotoId.jpg')
        .putFile(image!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  static Future<File?> compressImage(String photoId, File image) async {
    final tempDirection = await getTemporaryDirectory();  // GET A TEMPORARY PATH OF THE IMAGE
    final path = tempDirection.path;
    File? compressedImage = await FlutterImageCompress.compressAndGetFile(
      image.absolute.path,
      '$path/img_$photoId.jpg',
      quality: 70,
    );  // COMPRESSED THE FILE AND GET FILE
    return compressedImage; // RETURN THE COMPRESSED FILE
  }
}