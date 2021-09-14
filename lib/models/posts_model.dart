class PostsModel {
  int commentCount;
  String name;
  String tagline;
  int id;
  String thumbnail;
  String date;
  int votes;
  String screenShotUrl;
  List<PostComment> comments;

  PostsModel(
      {this.commentCount,
      this.name,
      this.tagline,
      this.id,
      this.thumbnail,
      this.date,
      this.votes,
      this.screenShotUrl,
      this.comments});

  static PostsModel fromJson(json) {
    return PostsModel(
        commentCount: json['comments_count'],
        name: json['name'],
        tagline: json['tagline'],
        id: json['id'],
        thumbnail: json['thumbnail']['image_url'],
        date: json['day'],
        votes: json['votes_count'],
        screenShotUrl: json['screenshot_url']['300px'],
        comments: PostComment.fromJson(json['comments'] ?? []));
  }
}

class PostComment {
  String profileUrl;
  String username;
  String comment;

  PostComment({this.comment, this.profileUrl, this.username});
  static List<PostComment> fromJson(json) {
    List<PostComment> postCom = [];
    json.forEach((comment) {
      postCom.add(PostComment(
          comment: comment['body'],
          profileUrl: comment['user']['image_url']['original'],
          username: comment['user']['username']));
    });
    // postCom.addAll();
    return postCom;
  }
}

// class PostsDetailModel {
//   int commentCount;
//   String name;
//   String tagline;
//   int id;
//   String thumbnail;
//   String date;
//   int votes;
//   String screenShotUrl;
//   PostsDetailModel(
//       {this.commentCount,
//       this.name,
//       this.tagline,
//       this.id,
//       this.thumbnail,
//       this.date,
//       this.votes,
//       this.screenShotUrl});

//   static PostsDetailModel fromJson(json) {
//     return PostsDetailModel(
//         commentCount: json['comments_count'],
//         name: json['name'],
//         tagline: json['tagline'],
//         id: json['id'],
//         thumbnail: json['thumbnail']['image_url'],
//         date: json['day'],
//         votes: json['votes_count'],
//         screenShotUrl: json['screenshot_url']['300px']);
//   }
// }
