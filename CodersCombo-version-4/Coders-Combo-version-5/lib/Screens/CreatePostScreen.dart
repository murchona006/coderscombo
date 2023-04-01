import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Constants/Constants.dart';
import '../Models/Post.dart';
import '../Services/DatabaseServices.dart';
import '../Services/StroageService.dart';
//import '../Services/StorageService.dart';

class CreatePostScreen extends StatefulWidget {

  final String currentUserId;

  const CreatePostScreen({super.key, required this.currentUserId});

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  String? _postText;
  File? _pickedImage;
  bool _loading = false;

  handleImageFromGallery() async{
    try{
      //File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
      //File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
      File imageFile = File(await ImagePicker().pickImage(source: ImageSource.gallery).then((pickedFile) => pickedFile!.path));
      if(imageFile != null){
        setState(() {
          _pickedImage=imageFile;
        });
      }
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        centerTitle: true,
        title: Text(
          'Share Your Ideas & Grows together!',
          style: TextStyle(
            color: AppColor_Black,
            fontSize: 15,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextField(
              maxLength: 280,
              maxLines: 7,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColor_White,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
                hintText: 'Decode your thoughts here!',
                hintStyle: TextStyle(
                  color: Colors.black45
                )
              ),
              onChanged: (value) {
                _postText = value;
              },
            ),
            SizedBox(height: 10),
            _pickedImage == null?
            SizedBox.shrink():
            Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: AppColor_Blue,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(_pickedImage!),
                      )
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),

            GestureDetector(
              onTap: handleImageFromGallery,
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(
                    color: AppColor_Blue,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.camera_alt,
                  size: 50,
                  color: AppColor_Blue,
                ),
              ),
            ),
            SizedBox(height: 20),

            MaterialButton(
              elevation: 10,
              color: Colors.white70,
              child: const Text(
                'Post',
                style: TextStyle(
                    color: AppColor_Blue,
                    fontSize: 20
                  ),
                ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              onPressed: () async{
                setState(() {
                  _loading=true;
                });
                if(_postText != null && _postText!.isNotEmpty){
                  String image;
                  if(_pickedImage==null){
                    image='';
                  }else{
                    //image = await StorageService.uploadTweetPicture(_pickedImage);
                    image = await StorageService.uploadTweetPicture(_pickedImage!);
                  }
                  Post post = Post(
                    text: _postText,
                    image: image,
                    authorId: widget.currentUserId,
                    likes: 0,
                    //share: 0,
                    timestamp: Timestamp.fromDate(DateTime.now(),
                    ),
                  );
                  DatabaseServices.createPost(post);
                  Navigator.pop(context);

                }
                setState(() {
                  _loading=false;
                });
                // else{
                //   print('Login Problem');
                // }
              },
              minWidth: 320,
              height: 60,
            ),
            SizedBox(height: 20),
            _loading ? CircularProgressIndicator() : SizedBox.shrink()
          ],
        ),
      ),

    );
  }
}


// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../Constants/Constants.dart';
// import '../Models/Tweet.dart';
// import '../Services/DatabaseServices.dart';
// import '../Services/StorageService.dart';
//
// class CreateTweetScreen extends StatefulWidget {
//   final String currentUserId;
//
//   //const CreateTweetScreen({Key? key, required this.currentUserId}) : super(key: key);
//   CreateTweetScreen({super.key, required this.currentUserId});
//
//   @override
//   _CreateTweetScreenState createState() => _CreateTweetScreenState();
// }
//
// class _CreateTweetScreenState extends State<CreateTweetScreen> {
//   late String _tweetText;
//   late File _pickedImage;
//   bool _loading = false;
//
//   handleImageFromGallery() async {
//     try {
//       // File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
//       File imageFile = File(await ImagePicker().pickImage(source: ImageSource.gallery).then((pickedFile) => pickedFile!.path));
//
//       if (imageFile != null) {
//         setState(() {
//           _pickedImage = imageFile;
//         });
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: KTweeterColor,
//         centerTitle: true,
//         title: Text(
//           'Tweet',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           children: [
//             SizedBox(height: 20),
//             TextField(
//               maxLength: 280,
//               maxLines: 7,
//               decoration: InputDecoration(
//                 hintText: 'Enter your Tweet',
//               ),
//               onChanged: (value) {
//                 _tweetText = value;
//               },
//             ),
//             SizedBox(height: 10),
//             _pickedImage == null
//                 ? SizedBox.shrink()
//                 : Column(
//               children: [
//                 Container(
//                   height: 200,
//                   decoration: BoxDecoration(
//                       color: KTweeterColor,
//                       image: DecorationImage(
//                         fit: BoxFit.cover,
//                         image: FileImage(_pickedImage),
//                       )),
//                 ),
//                 SizedBox(height: 20),
//               ],
//             ),
//             GestureDetector(
//               onTap: handleImageFromGallery,
//               child: Container(
//                 height: 70,
//                 width: 70,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                   border: Border.all(
//                     color: KTweeterColor,
//                     width: 2,
//                   ),
//                 ),
//                 child: Icon(
//                   Icons.camera_alt,
//                   size: 50,
//                   color: KTweeterColor,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             // RoundedButton(
//             //   btnText: 'Tweet',
//             //   onBtnPressed: () async {
//             //     setState(() {
//             //       _loading = true;
//             //     });
//             //     if (_tweetText != null && _tweetText.isNotEmpty) {
//             //       String image;
//             //       if (_pickedImage == null) {
//             //         image = '';
//             //       } else {
//             //         image =
//             //         await StorageService.uploadTweetPicture(_pickedImage);
//             //       }
//             //       Tweet tweet = Tweet(
//             //         text: _tweetText,
//             //         image: image,
//             //         authorId: widget.currentUserId,
//             //         likes: 0,
//             //         retweets: 0,
//             //         timestamp: Timestamp.fromDate(
//             //           DateTime.now(),
//             //         ),
//             //       );
//             //       DatabaseServices.createTweet(tweet);
//             //       Navigator.pop(context);
//             //     }
//             //     setState(() {
//             //       _loading = false;
//             //     });
//             //   },
//             // ),
//
//             MaterialButton(
//               elevation: 5,
//               color: Color(0xff00acee),
//               child: const Text('Tweet', style: TextStyle(color: Colors.white, fontSize: 20),),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//               onPressed: () async{
//                 setState(() {
//                   _loading=true;
//                 });
//                 if(_tweetText != null && _tweetText.isNotEmpty){
//                   String image;
//                   if(_pickedImage==null){
//                     image='';
//                   }else{
//                     //image = await StorageService.uploadTweetPicture(_pickedImage);
//                     image = await StorageService.uploadTweetPicture(_pickedImage);
//                   }
//                   Tweet tweet = Tweet(
//                     text: _tweetText,
//                     image: image,
//                     authorId: widget.currentUserId,
//                     likes: 0,
//                     retweets: 0,
//                     timestamp: Timestamp.fromDate(DateTime.now(),
//                     ),
//                   );
//                   DatabaseServices.createTweet(tweet);
//                   Navigator.pop(context);
//
//                 }
//                 setState(() {
//                   _loading=false;
//                 });
//                 // else{
//                 //   print('Login Problem');
//                 // }
//               },
//               minWidth: 320,
//               height: 60,
//             ),
//             SizedBox(height: 20),
//             _loading ? CircularProgressIndicator() : SizedBox.shrink()
//           ],
//         ),
//       ),
//     );
//   }
// }