import 'package:coderscombo/Screens/CreatePostScreen.dart';
import 'package:coderscombo/Screens/EditProfileScreen.dart';
import 'package:coderscombo/Screens/WelcomeScreen.dart';
import 'package:flutter/material.dart';

import '../Constants/Constants.dart';
import '../Models/Post.dart';
import '../Models/UserModel.dart';
import '../Services/DatabaseServices.dart';
import '../Services/auth_service.dart';
import '../Widgets/PostContainer.dart';

// class ProfileScreen extends StatefulWidget {
//   final String currentUserId;
//   final String visitedUserId;
//
//   const ProfileScreen({Key? key, required this.currentUserId, required this.visitedUserId}) // PARAMETERIZED CONSTRUCTOR
//       : super(key: key);
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   int _followersCount = 0;
//   int _followingCount = 0;
//   bool _isFollowing = false;
//   int _profileSegmentedValue = 0;
//   List<Post> _allPosts = [];
//   List<Post> _mediaPosts = [];
//
//   Map<int, Widget> _profileTabs = <int, Widget>{
//     0: Padding(
//       padding: EdgeInsets.symmetric(vertical: 10),
//       child: Text(
//         'Posts',
//         style: TextStyle(
//           fontSize: 13,
//           fontWeight: FontWeight.w700,
//           color: Colors.white,
//         ),
//       ),
//     ),
//     1: Padding(
//       padding: EdgeInsets.symmetric(vertical: 10),
//       child: Text(
//         'Media',
//         style: TextStyle(
//           fontSize: 13,
//           fontWeight: FontWeight.w700,
//           color: Colors.white,
//         ),
//       ),
//     ),
//   };
//
//   Widget buildProfileWidgets(UserModel author) {
//     switch (_profileSegmentedValue) {
//       case 0:
//         return Container(
//           decoration: BoxDecoration(
//             color: Colors.red,
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: ListView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: _allPosts.length,
//               itemBuilder: (context, index) {
//                 return PostContainer(
//                   currentUserId: widget.currentUserId,
//                   author: author,
//                   post: _allPosts[index],
//                 );
//               }),
//         );
//         break;
//       case 1:
//         return ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: _mediaPosts.length,
//             itemBuilder: (context, index) {
//               return PostContainer(
//                 currentUserId: widget.currentUserId,
//                 author: author,
//                 post: _mediaPosts[index],
//               );
//             });
//         break;
//       default:
//         return Center(
//             child: Text('Something wrong', style: TextStyle(fontSize: 25)));
//         break;
//     }
//   }
//
//   getFollowersCount() async {
//     int followersCount =
//     await DatabaseServices.followersNum(widget.visitedUserId);
//     if (mounted) {
//       setState(() {
//         _followersCount = followersCount;
//       });
//     }
//   }
//
//   getFollowingCount() async {
//     int followingCount =
//     await DatabaseServices.followingNum(widget.visitedUserId);
//     if (mounted) {
//       setState(() {
//         _followingCount = followingCount;
//       });
//     }
//   }
//
//   followOrUnFollow() {
//     if (_isFollowing) {
//       unFollowUser();
//     } else {
//       followUser();
//     }
//   }
//
//   unFollowUser() {
//     DatabaseServices.unFollowUser(widget.currentUserId, widget.visitedUserId);
//     setState(() {
//       _isFollowing = false;
//       _followersCount--;
//     });
//   }
//
//   followUser() {
//     DatabaseServices.followUser(widget.currentUserId, widget.visitedUserId);
//     setState(() {
//       _isFollowing = true;
//       _followersCount++;
//     });
//   }
//
//   setupIsFollowing() async {
//     bool isFollowingThisUser = await DatabaseServices.isFollowingUser(
//         widget.currentUserId, widget.visitedUserId);
//     setState(() {
//       _isFollowing = isFollowingThisUser;
//     });
//   }
//
//   getAllPosts() async{
//     List<Post>? userPosts = (await DatabaseServices.getUserPosts(widget.visitedUserId)).cast<Post>();
//     if(mounted){
//       setState(() {
//         _allPosts = userPosts;
//         _mediaPosts = _allPosts.where((element) => element.image!.isNotEmpty).toList();
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getFollowersCount();
//     getFollowingCount();
//     setupIsFollowing();
//     getAllPosts();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: Colors.white,
//           //backgroundColor: AppColor,
//           //child: Image.asset('assets/post2.png',),
//           child: Image.asset('assets/post_icon.png',),
//           onPressed: (){
//             Navigator.push(context, MaterialPageRoute(builder: (context)=>CreatePostScreen(currentUserId: widget.currentUserId)));
//           },
//         ),
//         //backgroundColor: Colors.white,
//         backgroundColor: AppColor_Blue,
//         body: FutureBuilder(
//           future: usersRef.doc(widget.visitedUserId).get(),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             if (!snapshot.hasData) {
//               return Center(
//                 child: CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation(AppColor_Blue),
//                 ),
//               );
//             }
//             UserModel userModel = UserModel.fromDoc(snapshot.data);
//             return ListView(
//               physics: const BouncingScrollPhysics(
//                   parent: AlwaysScrollableScrollPhysics()),
//               children: [
//                 Container(
//                   height: 150,
//                   decoration: BoxDecoration(
//                     color: AppColor_Blue,
//                     image: userModel.coverImage.isEmpty
//                         ? null
//                         : DecorationImage(
//                       fit: BoxFit.cover,
//                       image: NetworkImage(userModel.coverImage),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox.shrink(),
//                         widget.currentUserId == widget.visitedUserId
//                             ? PopupMenuButton(
//                           icon: Icon(
//                             Icons.more_horiz,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                           itemBuilder: (_) {
//                             return <PopupMenuItem<String>>[
//                               new PopupMenuItem(
//                                 child: Text('Logout'),
//                                 value: 'logout',
//                               )
//                             ];
//                           },
//                           onSelected: (selectedItem) {
//                             if (selectedItem == 'logout') {
//                               AuthService.logOut();
//                               Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           WelcomeScreen()));
//                             }
//                           },
//                         )
//                             : SizedBox(),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   transform: Matrix4.translationValues(0.0, -40.0, 0.0),
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           CircleAvatar(
//                             radius: 45,
//                             backgroundImage: userModel.profilePicture.isEmpty
//                                 ? AssetImage('assets/placeholder.png')
//                                 : NetworkImage(userModel.profilePicture) as ImageProvider,
//                           ),
//                           widget.currentUserId == widget.visitedUserId
//                               ? GestureDetector(
//                             onTap: () async {
//                               await Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => EditProfileScreen(
//                                     user: userModel,
//                                   ),
//                                   // builder: (context) => LoginScreen(
//                                   //   //user: userModel,
//                                   // ),
//                                 ),
//                               );
//                               setState(() {});
//                             },
//                             child: Container(
//                               width: 100,
//                               height: 35,
//                               padding:
//                               EdgeInsets.symmetric(horizontal: 10),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 color: Colors.white,
//                                 border: Border.all(color: AppColor_Blue),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   'Edit',
//                                   style: TextStyle(
//                                     fontSize: 17,
//                                     color: AppColor_Blue,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           )
//                               : GestureDetector(
//                             onTap: followOrUnFollow,
//                             child: Container(
//                               width: 100,
//                               height: 35,
//                               padding:
//                               EdgeInsets.symmetric(horizontal: 10),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 color: _isFollowing
//                                     ? Colors.white
//                                     : AppColor_Blue,
//                                 border: Border.all(color: AppColor_Blue),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   _isFollowing ? 'Following' : 'Follow',
//                                   style: TextStyle(
//                                     fontSize: 17,
//                                     color: _isFollowing
//                                         ? AppColor_Blue
//                                         : Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         userModel.name!,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         userModel.bio!,
//                         style: TextStyle(
//                           color: Colors.white60,
//                           fontSize: 15,
//                         ),
//                       ),
//                       SizedBox(height: 15),
//                       Row(
//                         children: [
//                           Text(
//                             '$_followingCount Following',
//                             style: TextStyle(
//                               color: Colors.white70,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 2,
//                             ),
//                           ),
//                           SizedBox(width: 20),
//                           Text(
//                             '$_followersCount Followers',
//                             style: TextStyle(
//                               color: Colors.white70,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 2,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 20),
//                       Container(
//                         width: MediaQuery.of(context).size.width,
//                         child: CupertinoSlidingSegmentedControl(
//                           groupValue: _profileSegmentedValue,
//                           thumbColor: AppColor_Blue,
//                           backgroundColor: Colors.blueGrey,
//                           children: _profileTabs,
//                           onValueChanged: (i) {
//                             setState(() {
//                               _profileSegmentedValue = i as int;
//                             });
//                           },
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 buildProfileWidgets(userModel),
//               ],
//             );
//           },
//         ));
//   }
// }
class ProfileScreen extends StatefulWidget {
  final String currentUserId;
  final String visitedUserId;

  const ProfileScreen(
      {Key? key,
      required this.currentUserId,
      required this.visitedUserId}) // PARAMETERIZED CONSTRUCTOR
      : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _followersCount = 0;
  int _followingCount = 0;
  bool _isFollowing = false;
  int _profileSegmentedValue = 0;
  List<Post> _allPosts = [];
  List<Post> _mediaPosts = [];

  Widget buildProfileWidgets(UserModel author) {
    //switch (_profileSegmentedValue) {
    //  case 0:
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _allPosts.length,
        itemBuilder: (context, index) {
          return PostContainer(
            currentUserId: widget.currentUserId,
            author: author,
            post: _allPosts[index],
          );
        });
    // break;
    //  case 1:
    //    return ListView.builder(
    //        shrinkWrap: true,
    //        physics: NeverScrollableScrollPhysics(),
    //        itemCount: _mediaPosts.length,
    //   itemBuilder: (context, index) {
    //    return PostContainer(
    //      currentUserId: widget.currentUserId,
    //      author: author,
    //      post: _mediaPosts[index],
    //    );
    //  };
    //);
    // break;
    //default:
    return Center(
        child: Text('Something wrong', style: TextStyle(fontSize: 25)));

    //  break;
  }

  getFollowersCount() async {
    int followersCount =
        await DatabaseServices.followersNum(widget.visitedUserId);
    if (mounted) {
      setState(() {
        _followersCount = followersCount;
      });
    }
  }

  getFollowingCount() async {
    int followingCount =
        await DatabaseServices.followingNum(widget.visitedUserId);
    if (mounted) {
      setState(() {
        _followingCount = followingCount;
      });
    }
  }

  followOrUnFollow() {
    if (_isFollowing) {
      unFollowUser();
    } else {
      followUser();
    }
  }

  unFollowUser() {
    DatabaseServices.unFollowUser(widget.currentUserId, widget.visitedUserId);
    setState(() {
      _isFollowing = false;
      _followersCount--;
    });
  }

  followUser() {
    DatabaseServices.followUser(widget.currentUserId, widget.visitedUserId);
    setState(() {
      _isFollowing = true;
      _followersCount++;
    });
  }

  setupIsFollowing() async {
    bool isFollowingThisUser = await DatabaseServices.isFollowingUser(
        widget.currentUserId, widget.visitedUserId);
    setState(() {
      _isFollowing = isFollowingThisUser;
    });
  }

  getAllPosts() async {
    List<Post>? userPosts =
        (await DatabaseServices.getUserPosts(widget.visitedUserId))
            .cast<Post>();
    if (mounted) {
      setState(() {
        _allPosts = userPosts;
        _mediaPosts =
            _allPosts.where((element) => element.image!.isNotEmpty).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getFollowersCount();
    getFollowingCount();
    setupIsFollowing();
    getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
//           //backgroundColor: AppColor,
//          //child: Image.asset('assets/post2.png',),
          child: Image.asset(
            'assets/post.png',
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CreatePostScreen(currentUserId: widget.currentUserId)));
          },
        ),
//         //backgroundColor: Colors.white,
        backgroundColor: AppColor_White,
        //backgroundColor: Colors.grey.shade400,
        body: FutureBuilder(
            future: usersRef.doc(widget.visitedUserId).get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(AppColor_Blue),
                  ),
                );
              }
              UserModel userModel = UserModel.fromDoc(snapshot.data);
              return ListView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: AppColor_Blue,
                        image: userModel.coverImage.isEmpty
                            ? null
                            : DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(userModel.coverImage),
                              ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox.shrink(),
                            widget.currentUserId == widget.visitedUserId
                                ? PopupMenuButton(
                                    icon: Icon(
                                      Icons.more_horiz,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    itemBuilder: (_) {
                                      return <PopupMenuItem<String>>[
                                        new PopupMenuItem(
                                          child: Text('Logout'),
                                          value: 'logout',
                                        )
                                      ];
                                    },
                                    onSelected: (selectedItem) {
                                      if (selectedItem == 'logout') {
                                        AuthService.logOut();
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    WelcomeScreen()));
                                      }
                                    },
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CircleAvatar(
                                  radius: 45,
                                  backgroundImage: userModel
                                          .profilePicture.isEmpty
                                      ? AssetImage('assets/placeholder.png')
                                      : NetworkImage(userModel.profilePicture)
                                          as ImageProvider,
                                ),
                                widget.currentUserId == widget.visitedUserId
                                    ? GestureDetector(
                                        onTap: () async {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditProfileScreen(
                                                user: userModel,
                                              ),
//                                   // builder: (context) => LoginScreen(
//                                   //   //user: userModel,
//                                   // ),
                                            ),
                                          );
                                          setState(() {});
                                        },
                                        child: Container(
                                          width: 70,
                                          height: 35,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          // decoration: BoxDecoration(
                                          //   borderRadius: BorderRadius.circular(20),
                                          //   color: Colors.white,
                                          //   border: Border.all(color: AppColor_Blue),
                                          // ),
                                          child: Center(
                                            // child: Image.network(
                                            //     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQm1_GfEtPwInOTX60YtJXhvgm7w-3XyKPjjnfpzMndTtQHVnGdR6zkHNE6P60qg-DnYdA&usqp=CAU"
                                            // ),
                                            child: Icon(
                                              Icons.edit,
                                              size: 25,
                                              color: AppColor_Gray,
                                            ),
                                            //  child: Text(
                                            //    'Edit',
                                            //    style: TextStyle(
                                            //      fontSize: 17,
                                            //      color: AppColor,
                                            //      fontWeight: FontWeight.bold,
                                            //    ),
                                            //),
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: followOrUnFollow,
                                        child: Container(
                                          width: 100,
                                          height: 35,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: _isFollowing
                                                ? Colors.white
                                                : AppColor_Blue,
                                            border: Border.all(
                                                color: AppColor_Blue),
                                          ),
                                          child: Center(
                                            child: Text(
                                              _isFollowing
                                                  ? 'Following'
                                                  : 'Follow',
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: _isFollowing
                                                    ? AppColor_Blue
                                                    : Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              userModel.name!,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              userModel.bio!,
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Text(
                                  '$_followingCount Following',
                                  style: TextStyle(
                                    //color: Colors.white70,
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 2,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Text(
                                  '$_followersCount Followers',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                    //POst and Media
                    SizedBox(height: 20),

                    buildProfileWidgets(userModel)
                  ]);
            }));
  }
}
