// import 'package:coderscombo/Constants/Constants.dart';
// import 'package:coderscombo/Models/UserModel.dart';
// import 'package:coderscombo/Screens/CreatePostScreen.dart';
// import 'package:coderscombo/Services/DatabaseServices.dart';
// import 'package:flutter/material.dart';
//
// import '../Models/Post.dart';
// import '../Widgets/PostContainer.dart';
// import '../chatbot/bot.dart';
//
// class HomeScreen extends StatefulWidget {
//   //get currentUserId => null;
//   final String currentUserId;
//
//   const HomeScreen({super.key, required this.currentUserId});
//
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   List _followingPosts = [];
//   bool _loading = false;
//
//   buildPosts(Post post, UserModel author){
//     return Container(
//         padding: EdgeInsets.symmetric(horizontal: 15),
//         child: PostContainer(
//           post: post,
//           author: author,
//           currentUserId: widget.currentUserId,
//         )
//     );
//   }
//
//   // cardview(){
//   //   showfollowingPosts(widget.currentUserId);
//   // }
//
//   showfollowingPosts(String currentUserId){
//     List<Widget> followingPostsList=[];
//     for(Post post in _followingPosts){
//       followingPostsList.add(
//           FutureBuilder(
//               future: usersRef.doc(post.authorId).get(),
//               builder: (BuildContext context, AsyncSnapshot snapshot){
//                 if(snapshot.hasData){
//                   UserModel author = UserModel.fromDoc(snapshot.data);
//                   return buildPosts(post, author);
//                 }else{
//                   return SizedBox.shrink();
//                 }
//               }
//           )
//       );
//     }
//     return followingPostsList;
//   }
//
//   setupFollowingPosts()async{
//     setState(() {
//       _loading=true;
//     });
//     List followingPosts = await DatabaseServices.getHomePosts(widget.currentUserId);
//
//     if(mounted){
//       setState(() {
//         _followingPosts = followingPosts;
//         _loading=false;
//       });
//     }
//   }
//
//   void initState(){
//     super.initState();
//     setupFollowingPosts();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       //backgroundColor: Color.fromARGB(255,1,37,66),
//         backgroundColor: AppColor_White,
//         // floatingActionButton: FloatingActionButton(
//         //   backgroundColor: Colors.white,
//         //   child: Image.asset('assets/post2.png',),
//         //   onPressed: (){
//         //     Navigator.push(context, MaterialPageRoute(builder: (context)=>CreatePostScreen(currentUserId: widget.currentUserId)));
//         //   },
//         // ),
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: Colors.white,
//           child: Image.asset('assets/chatbot.png',),
//           onPressed: (){
//             Navigator.push(context, MaterialPageRoute(builder: (context)=>bot()));
//           },
//         ),
//
//         appBar: AppBar(
//           //backgroundColor: Color.fromARGB(255,1,37,66),//Colors.white,
//           //backgroundColor: AppColor,
//           //backgroundColor: Color.fromARGB(35, 41, 53, 1),
//           backgroundColor: AppColor_Blue,
//           elevation: 0.5,
//           centerTitle: true,
//           leading: Container(
//             height: 40,
//             child: Image.asset('assets/Logo_TW1.png'),
//           ),
//           title: Text(
//             'CodersCombo',
//             style: TextStyle(
//               color: Colors.white,//AppColor,
//             ),
//
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(
//               bottom: Radius.circular(15),
//             ),
//           ),
//         ),
//
//
//         body: RefreshIndicator(
//           onRefresh: ()=> setupFollowingPosts(),
//
//           child: ListView(
//             physics: BouncingScrollPhysics(
//               parent: AlwaysScrollableScrollPhysics(),
//             ),
//
//             children: [
//               _loading? LinearProgressIndicator():SizedBox.shrink(),
//               SizedBox(height: 5),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   SizedBox(height: 5),
//                   Column(
//                     children: _followingPosts.isEmpty && _loading==false?[
//                       SizedBox(height: 5),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 25),
//                         child: Text(
//                           'There is no new posts!',
//                           style: TextStyle(
//                             fontSize: 20,
//                           ),
//                         ),
//                       )
//                     ]:showfollowingPosts(widget.currentUserId),
//                   )
//                 ],
//               )
//             ],
//           ),
//         )
//     );
//   }
// }

import 'package:coderscombo/Constants/Constants.dart';
import 'package:coderscombo/Models/UserModel.dart';
import 'package:coderscombo/Screens/CreatePostScreen.dart';
import 'package:coderscombo/Services/DatabaseServices.dart';
import 'package:flutter/material.dart';

import '../Models/Post.dart';
import '../Widgets/PostContainer.dart';
import '../chatbot/bot.dart';

class HomeScreen extends StatefulWidget {
  //get currentUserId => null;
  final String currentUserId;

  const HomeScreen({super.key, required this.currentUserId});


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List _followingPosts = [];
  bool _loading = false;

  buildPosts(Post post, UserModel author){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: PostContainer(
          post: post,
          author: author,
          currentUserId: widget.currentUserId,
        )
    );
  }

  showfollowingPosts(String currentUserId){
    List<Widget> followingPostsList=[];
    for(Post post in _followingPosts){
      followingPostsList.add(
          FutureBuilder(
              future: usersRef.doc(post.authorId).get(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.hasData){
                  UserModel author = UserModel.fromDoc(snapshot.data);
                  return buildPosts(post, author);
                }else{
                  return SizedBox.shrink();
                }
              }
          )
      );
    }
    return followingPostsList;
  }

  setupFollowingPosts()async{
    setState(() {
      _loading=true;
    });
    List followingPosts = await DatabaseServices.getHomePosts(widget.currentUserId);

    if(mounted){
      setState(() {
        _followingPosts = followingPosts;
        _loading=false;
      });
    }
  }

  void initState(){
    super.initState();
    setupFollowingPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(255,1,37,66),
        backgroundColor: AppColor_White,
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.white,
        //   child: Image.asset('assets/post2.png',),
        //   onPressed: (){
        //     Navigator.push(context, MaterialPageRoute(builder: (context)=>CreatePostScreen(currentUserId: widget.currentUserId)));
        //   },
        // ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Image.asset('assets/chatbot.png',),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>bot()));
          },
        ),

        appBar: AppBar(
          //backgroundColor: Color.fromARGB(255,1,37,66),//Colors.white,
          backgroundColor: Colors.grey[300],
          elevation: 10,
          centerTitle: true,
          leading: Container(
            height: 40,
            child: Image.asset('assets/Logo_TBW1.png'),
          ),
          title: Text(
            'CodersCombo',
            style: TextStyle(
              color: Colors.black,//AppColor,
            ),


          ),
          shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.vertical(
               bottom: Radius.circular(15),
             ),
           ),
        ),
        body: RefreshIndicator(
          onRefresh: ()=> setupFollowingPosts(),

          child: ListView(
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),

            children: [
              _loading? LinearProgressIndicator():SizedBox.shrink(),
              SizedBox(height: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 5),
                  Column(
                    children: _followingPosts.isEmpty && _loading==false?[
                      SizedBox(height: 5),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            'There is no new posts!',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )
                      )
                    ]:showfollowingPosts(widget.currentUserId),
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}

