import 'dart:convert';

import 'package:haptik_assignment/models/posts_model.dart';
import 'package:haptik_assignment/utilities/utilities.dart';
import 'package:http/http.dart' as http;

class PostsService {
  final postsListUrl = Uri.parse(baseUrl + 'posts');

  Future<List<PostsModel>> getPosts() async {
    try {
      var response = await http.get(
        postsListUrl,
        headers: <String, String>{
          // 'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $apiToken'
        },
      );
      if (response.statusCode == 200) {
        var responsebody = json.decode(response.body);
        prefs.setString('offlineData', response.body);
        List<PostsModel> listofPosts = [];
        listofPosts = (responsebody["posts"] as List)
            .map((k) => PostsModel.fromJson(k))
            .toList();

        return listofPosts;
      } else {
        throw Exception();
      }
    } catch (SocketException) {
      var responsebody = json.decode(prefs.getString('offlineData'));
      List<PostsModel> listofPosts = [];
      listofPosts = (responsebody["posts"] as List)
          .map((k) => PostsModel.fromJson(k))
          .toList();

      return listofPosts;
    }
  }

  Future<PostsModel> getDetailPost(id) async {
    final postDetailtUrl = Uri.parse(baseUrl + 'posts/$id');
    var response = await http.get(
      postDetailtUrl,
      headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $apiToken'
      },
    );
    if (response.statusCode == 200) {
      var responsebody = json.decode(response.body);
      PostsModel postsDetailModel;
      postsDetailModel = PostsModel.fromJson(responsebody['post']);

      return postsDetailModel;
    } else {
      throw Exception();
    }
  }
}
