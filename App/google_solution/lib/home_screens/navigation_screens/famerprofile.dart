import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmers_market/NewProduct.dart';
import 'package:farmers_market/home_screens/navigation_screens/profile_pic.dart';
import 'package:flutter/material.dart';

import '../posts_provider.dart';
import '../widgets/post.dart';

Map<String, dynamic> details = new Map();

class farmerprofile extends StatelessWidget {
  Future<void> getdetails() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.settings = const Settings(persistenceEnabled: false);
    final result =
        await db.collection("Farmer's Item").doc(new_product.user_id).get();
    details = result.data();
    print(details);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
            child: Container(
                padding:
                    EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 12),
                child: FutureBuilder<void>(
                    future: getdetails(),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      List<Widget> children = new List();
                      if (details != null) {
                        children = <Widget>[
                          Row(
                            children: <Widget>[
                              ProfilePic(
                                radius: 40,
                                profilePic:
                                    "https://static8.depositphotos.com/1001911/819/v/950/depositphotos_8192441-stock-illustration-angry-kid.jpg?forcejpeg=true",
                              ),
                              SizedBox(
                                width: 24,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    details["Name"],
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "  ",
                                    style: TextStyle(
                                        fontSize: 2,
                                        color: Colors.grey.shade700),
                                  ),
                                  Text(
                                    details["Address"],
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade700),
                                  ),
                                  Text(
                                    "  ",
                                    style: TextStyle(
                                        fontSize: 2,
                                        color: Colors.grey.shade700),
                                  ),
                                  Text(
                                    details["Email"],
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade700),
                                  ),
                                  Text(
                                    "  ",
                                    style: TextStyle(
                                        fontSize: 2,
                                        color: Colors.grey.shade700),
                                  ),
                                  Text(
                                    "Phone: " + details["Phone"],
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade700),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Divider(
                            height: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 26, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "700",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Posts",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.shade700),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "18m",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Followers",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.shade700),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "10",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Following",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.shade700),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                          ),
                        ];
                      } else {
                        children = const <Widget>[
                          Center(
                              child: SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(),
                          )),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text('loading'),
                          )
                        ];
                      }
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: children);
                    }))),
        /*SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Card(
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        gradient: LinearGradient(
                          colors: [Color(0xff5778DA), Color(0xff8970D8)],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "FOLLOW",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                IconButton(icon: Icon(Icons.send), onPressed: () {})
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 100,
            child: ListView.builder(
              itemBuilder: (_, position) {
                Post post = PostsProvider.posts[position];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    width: 55,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ProfilePic(
                          profilePic: post.profilePicUrl ?? "",
                          radius: 25,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          post.username,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
              scrollDirection: Axis.horizontal,
              itemCount: PostsProvider.posts.length,
            ),
          ),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, position) {
              Post post = PostsProvider.posts[position];
              return Image.network(
                post.imageUrl,
                fit: BoxFit.fill,
              );
            },
            childCount: PostsProvider.posts.length,
          ),
        ),*/
      ],
    );
  }
}
