import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haptik_assignment/cubit/HomeScreen/homescreen_cubit.dart';
import 'package:haptik_assignment/models/posts_model.dart';
import 'package:haptik_assignment/screens/post_deatil.dart';
import 'package:haptik_assignment/services/posts_service.dart';
import 'package:connectivity/connectivity.dart';
import 'package:haptik_assignment/utilities/network_aware.dart';
import 'package:haptik_assignment/utilities/utilities.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

enum NetworkStatus { Online, Offline }

class NetworkStatusService {
  StreamController<NetworkStatus> networkStatusController =
      StreamController<NetworkStatus>();

  NetworkStatusService() {
    Connectivity().onConnectivityChanged.listen((status) {
      networkStatusController.add(_getNetworkStatus(status));
    });
  }

  NetworkStatus _getNetworkStatus(ConnectivityResult status) {
    return status == ConnectivityResult.mobile ||
            status == ConnectivityResult.wifi
        ? NetworkStatus.Online
        : NetworkStatus.Offline;
  }
}

class HomeScreenMobilePortrait extends StatefulWidget {
  @override
  _HomeScreenMobilePortraitState createState() =>
      _HomeScreenMobilePortraitState();
}

class _HomeScreenMobilePortraitState extends State<HomeScreenMobilePortrait> {
  // scaffold key

  List<PostsModel> listPosts = [];

  List<PostsModel> searchPosts = [];

  bool loading = true;
  TextEditingController searchController = TextEditingController();
  bool offlineData = false;
  @override
  void initState() {
    super.initState();
    getPosts();
    // initialising the controller
  }

  getPosts() async {
    offlineData = prefs.getString("offlineData") != null ? true : false;
    print(networkStatus == NetworkStatus.Online);
    listPosts = await PostsService().getPosts();

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    networkStatus = Provider.of<NetworkStatus>(context);
    if (networkStatus == NetworkStatus.Online) {
      getPosts();
    }
    return Scaffold(
      appBar: AppBar(),
      body: NetworkAwareWidget(
        onlineChild: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: TextField(
                onChanged: (value) {
                  searchPosts = [];
                  setState(() {
                    loading = true;
                  });
                  listPosts.forEach((element) {
                    if (element.name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase()) ||
                        element.tagline
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                      searchPosts.add(element);
                    }
                  });
                  setState(() {
                    loading = false;
                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Today's Posts",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: searchPosts.length > 0
                        ? ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: searchPosts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, PostDetailScreen.id,
                                      arguments: searchPosts[index].id);
                                },
                                child: CustomListItemTwo(
                                  thumbnail: Container(
                                    // decoration: const BoxDecoration(color: Colors.pink),
                                    child: CachedNetworkImage(
                                      imageUrl: searchPosts[index].thumbnail,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: searchPosts[index].name,
                                  subtitle: searchPosts[index].tagline,
                                  author:
                                      'Comments - ${searchPosts[index].commentCount}',
                                  publishDate: searchPosts[index].date,
                                  readDuration:
                                      '${searchPosts[index].votes} votes',
                                ),
                              );
                            })
                        : ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: listPosts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, PostDetailScreen.id,
                                      arguments: listPosts[index].id);
                                },
                                child: CustomListItemTwo(
                                  thumbnail: Container(
                                    // decoration: const BoxDecoration(color: Colors.pink),
                                    child: Image.network(
                                      listPosts[index].thumbnail,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: listPosts[index].name,
                                  subtitle: listPosts[index].tagline,
                                  author:
                                      'Comments - ${listPosts[index].commentCount}',
                                  publishDate: listPosts[index].date,
                                  readDuration:
                                      '${listPosts[index].votes} votes',
                                ),
                              );
                            }),
                  ),
          ],
        ),
        offlineChild: offlineData
            ? Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: TextField(
                      onChanged: (value) {
                        searchPosts = [];
                        setState(() {
                          loading = true;
                        });
                        listPosts.forEach((element) {
                          if (element.name.toLowerCase().contains(
                                  searchController.text.toLowerCase()) ||
                              element.tagline.toLowerCase().contains(
                                  searchController.text.toLowerCase())) {
                            searchPosts.add(element);
                          }
                        });
                        setState(() {
                          loading = false;
                        });
                      },
                      controller: searchController,
                      decoration: InputDecoration(
                          labelText: "Search",
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Today's Posts",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Expanded(
                          child: searchPosts.length > 0
                              ? ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemCount: searchPosts.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, PostDetailScreen.id,
                                            arguments: searchPosts[index].id);
                                      },
                                      child: CustomListItemTwo(
                                        thumbnail: Container(
                                          // decoration: const BoxDecoration(color: Colors.pink),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                searchPosts[index].thumbnail,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        title: searchPosts[index].name,
                                        subtitle: searchPosts[index].tagline,
                                        author:
                                            'Comments - ${searchPosts[index].commentCount}',
                                        publishDate: searchPosts[index].date,
                                        readDuration:
                                            '${searchPosts[index].votes} votes',
                                      ),
                                    );
                                  })
                              : ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemCount: listPosts.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, PostDetailScreen.id,
                                            arguments: listPosts[index].id);
                                      },
                                      child: CustomListItemTwo(
                                        thumbnail: Container(
                                          // decoration: const BoxDecoration(color: Colors.pink),
                                          child: Image.network(
                                            listPosts[index].thumbnail,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        title: listPosts[index].name,
                                        subtitle: listPosts[index].tagline,
                                        author:
                                            'Comments - ${listPosts[index].commentCount}',
                                        publishDate: listPosts[index].date,
                                        readDuration:
                                            '${listPosts[index].votes} votes',
                                      ),
                                    );
                                  }),
                        ),
                ],
              )
            : Center(
                child: Text("No internet Connection..!!!!"),
              ),
      ),
    );
  }
}

class CustomListItemTwo extends StatelessWidget {
  CustomListItemTwo({
    this.thumbnail,
    this.title,
    this.subtitle,
    this.author,
    this.publishDate,
    this.readDuration,
  });

  final Widget thumbnail;
  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: thumbnail,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _ArticleDescription(
                  title: title,
                  subtitle: subtitle,
                  author: author,
                  publishDate: publishDate,
                  readDuration: readDuration,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ArticleDescription extends StatelessWidget {
  const _ArticleDescription({
    this.title,
    this.subtitle,
    this.author,
    this.publishDate,
    this.readDuration,
  });

  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Expanded(
                child: Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                author,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                '$publishDate - $readDuration',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
