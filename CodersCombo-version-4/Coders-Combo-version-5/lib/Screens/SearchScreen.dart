import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coderscombo/Constants/Constants.dart';
import 'package:coderscombo/Models/UserModel.dart';
import 'package:coderscombo/Screens/ProfileScreen.dart';
import 'package:flutter/material.dart';

import '../Services/DatabaseServices.dart';

class SearchScreen extends StatefulWidget {

  final String currentUserId;

  const SearchScreen({Key? key, required this.currentUserId}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<QuerySnapshot> ?_users;
  TextEditingController _searchController = TextEditingController();

  clearSearch(){
    WidgetsBinding.instance.addPostFrameCallback((_)=>_searchController.clear());

    setState(() {
      _users=null!;
    });
  }

  buildUserTile(UserModel user){
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: user.profilePicture.isEmpty?
         AssetImage('assets/placeholder.png'):
        NetworkImage(user.profilePicture) as ImageProvider,
      ),
      title: Text(user.name!),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>ProfileScreen(
            currentUserId: widget.currentUserId,
            visitedUserId: user.id!,
          ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        centerTitle: true,
        elevation: 5,
        title: TextField(
          controller: _searchController,
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
            contentPadding: EdgeInsets.symmetric(vertical: 15),
            hintText: 'Search Coders...',
            hintStyle: TextStyle(color: Colors.black54),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.black54),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.black54,
              ),
              onPressed: (){
                clearSearch();
              },
            ),
            filled: true,
          ),
          onChanged: (input){
            if(input.isNotEmpty){
              setState(() {
                _users=DatabaseServices.searchUsers(input);
              });
            }
          },

        ),
      ),
      body: _users==null?
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
                Icons.search, size: 200,
              color: AppColor_Blue,
            ),
            Text(
              'Search Coders...',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                color: AppColor_Blue
                ),

              ),
          ],
        ),
      )
          : FutureBuilder<QuerySnapshot<Object?>>(
          future: _users,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            //if(snapshot.data.documents.length==0){
            if(snapshot.data!.docs.length==0){
              return Center(
                child: Text('No Coders Found!'),
              );
            }
            return ListView.builder(
              //itemCount: snapshot.data!.documents.length,//
                itemCount: snapshot.data!.docs.length,//
                itemBuilder: (BuildContext context, int index){
                  //UserModel user = UserModel.fromDoc(snapshot.data.documents[index]);//
                  UserModel user = UserModel.fromDoc(snapshot.data!.docs[index]);//

                  return buildUserTile(user);
                }
            );
          }
      ),
    );
  }
}
