import 'package:flutter/material.dart';
import 'package:haptik_assignment/core/responsive/builders/orientation_layout.dart';
import 'package:haptik_assignment/core/responsive/builders/screen_type_layout.dart';
import 'package:haptik_assignment/screens/post_detail_screen.dart';

class PostDetailScreen extends StatefulWidget {
  static const String id = 'postDetail';
  final postId;
  PostDetailScreen({this.postId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<PostDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: PostDetailScreenPortrait(
          postid: widget.postId,
        ),
      ),
    );
  }
}
