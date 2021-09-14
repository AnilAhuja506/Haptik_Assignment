import 'package:flutter/material.dart';
import 'package:haptik_assignment/models/posts_model.dart';
import 'package:haptik_assignment/services/posts_service.dart';

class PostDetailScreenPortrait extends StatefulWidget {
  final postid;
  const PostDetailScreenPortrait({this.postid});

  @override
  _PostDetailScreenPortraitState createState() =>
      _PostDetailScreenPortraitState();
}

class _PostDetailScreenPortraitState extends State<PostDetailScreenPortrait> {
  PostsModel postDetail;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    getPosts();
    // initialising the controller
  }

  getPosts() async {
    postDetail = await PostsService().getDetailPost(widget.postid);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Image.network(
                      postDetail.screenShotUrl,
                      fit: BoxFit.cover,
                    ),
                    height: 250,
                    // color: Colors.red,
                  ),
                  Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: postDetail.comments.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(5),
                            // height: 200,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          // color: Colors.blue,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                postDetail
                                                    .comments[index].profileUrl,
                                              ))),
                                      height: 50,
                                      width: 50,
                                    ),
                                    Expanded(
                                        child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                          postDetail.comments[index].username),
                                    ))
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                          postDetail.comments[index].comment)),
                                )
                              ],
                            ),
                            color: Colors.amberAccent,
                          );
                        }),
                  ),
                ],
              ));
  }
}
