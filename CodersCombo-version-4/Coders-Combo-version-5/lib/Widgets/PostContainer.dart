import 'package:coderscombo/Constants/Constants.dart';
import 'package:coderscombo/Services/DatabaseServices.dart';
import 'package:flutter/material.dart';

import '../Models/Post.dart';
import '../Models/UserModel.dart';


class PostContainer extends StatefulWidget {

  final Post post;
  final UserModel author;
  final String currentUserId;

  const PostContainer({super.key, required this.post, required this.author, required this.currentUserId});
  //const TweetContainer({super.key, required this.tweet, required this.author});
  @override
  _PostContainerState createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {

  int _likesCount=0;
  bool _isLiked=false;

  initPostLikes() async{
    bool isLiked = await DatabaseServices.isLikePost(widget.currentUserId, widget.post);

    if(mounted){
      setState(() {
        _isLiked = isLiked;
      });
    }

  }

  likedPost(){
    if(_isLiked){
      DatabaseServices.unlikePost(widget.currentUserId, widget.post);
      setState(() {
        _isLiked=false;
        _likesCount--;
      });
    }else{
      DatabaseServices.likePost(widget.currentUserId, widget.post);
      setState(() {
        _isLiked=true;
        _likesCount++;
      });
    }
  }

  void initState(){
    super.initState();
    _likesCount = widget.post.likes!;
    initPostLikes();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: widget.author.profilePicture.isEmpty
                      ? AssetImage('assets/placeholder.png')
                      : NetworkImage(widget.author.profilePicture) as ImageProvider,
                ),
                SizedBox(width: 10),
                Text(
                  widget.author.name!,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    //color: Colors.white,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(
                widget.post.text!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                )
            ),
            widget.post.image!.isEmpty
                ? SizedBox.shrink()
                : Column(
              children: [
                SizedBox(height: 15),
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                      color: AppColor_Blue,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.post.image!),
                      )
                  ),
                )
              ],
            ),

            SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            //_isLiked?Icons.favorite:Icons.favorite_border,
                            //_isLiked?Icons.sunny:Icons.lightbulb,
                            _isLiked?Icons.thumb_up:Icons.thumb_up_alt_outlined,
                            //color: _isLiked? AppColor:Colors.white,
                            color: _isLiked? AppColor_Blue:Colors.black,
                          ),
                          onPressed: likedPost,
                        ),
                        Text(
                          _likesCount.toString()+' Likes',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     IconButton(
                    //       icon: Icon(Icons.repeat),
                    //       onPressed: () {},
                    //     ),
                    //     Text(
                    //       widget.post.share.toString()+' Share',
                    //     ),
                    //   ],
                    // ),
                  ],

                ),

                Text(
                  widget.post.timestamp!.toDate().toString().substring(0, 19),
                  style: TextStyle(color: Colors.black45),
                ),

              ],
            ),
            SizedBox(height: 10),
            Divider(
              thickness: 1,
              indent: 1,
              //endIndent: 6,
              color: Colors.grey.shade400,


            ),
          ],
        )
    );
  }
}
